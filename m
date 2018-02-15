From: ebiederm@xmission.com (Eric W. Biederman)
Date: Thu, 15 Feb 2018 10:47:06 -0600
Subject: [RFC PATCH 2/4] ima: fail signature verification on unprivileged
	& untrusted filesystems
In-Reply-To: <1518698285.5667.87.camel@linux.vnet.ibm.com> (Mimi Zohar's
	message of "Thu, 15 Feb 2018 07:38:05 -0500")
References: <1518615315-7162-1-git-send-email-zohar@linux.vnet.ibm.com>
	<1518615315-7162-2-git-send-email-zohar@linux.vnet.ibm.com>
	<87po57yvix.fsf@xmission.com>
	<1518698285.5667.87.camel@linux.vnet.ibm.com>
Message-ID: <87a7wayzcl.fsf@xmission.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Mimi Zohar <zohar@linux.vnet.ibm.com> writes:

> On Wed, 2018-02-14 at 17:57 -0600, Eric W. Biederman wrote:
>> Mimi Zohar <zohar@linux.vnet.ibm.com> writes:
>> 
>> > Files on untrusted filesystems, such as fuse, can change at any time,
>> > making the measurement(s) and by extension signature verification
>> > meaningless.
>> >
>> > FUSE can be mounted by unprivileged users either today with fusermount
>> > installed with setuid, or soon with the upcoming patches to allow FUSE
>> > mounts in a non-init user namespace.
>> >
>> > This patch always fails the file signature verification on unprivileged
>> > and untrusted filesystems.  To also fail file signature verification on
>> > privileged, untrusted filesystems requires a custom policy.
>> >
>> > (This patch is based on Alban Crequy's use of fs_flags and patch
>> >  description.)
>> 
>> This would be much better done based on a flag in s_iflags and then the
>> mounts that need this can set this.  That new flag can perhaps be called
>> SB_I_IMA_FAIL.
>> 
>> Among other things that should allow the policy of when to set this to
>> be set in fuse where it is obvious rather than in an magic location in
>> IMA.
>
> Using s_iflags instead of fs_flags is fine, but I'm not sure how this
> affects the IMA policy. ?This patch set assumes only unprivileged,
> untrusted filesytems can automatically fail file signature
> verification (2nd patch), as that hasn't yet been upstreamed and won't
> break userspace.
>
> Based on policy, IMA should additionally be able to fail the signature
> verification for files on privileged, untrusted filesystems.

Apologies ima has a very specific meaning of policy, as in the loaded
ima policy.  I was meaning the hard coded policy of which filesystems
we simply would not trust by default.

In code terms what I was thinking would look something like:

diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -292,7 +292,14 @@ int ima_appraise_measurement(enum ima_hooks func,
 	}
  
 out:
-	if (status != INTEGRITY_PASS) {
+	/* Fail if we can't trust the fs enough to support ima xattrs (FUSE) */
+	if (inode->i_sb->s_iflags & SB_I_NOIMA) {
+		status = INTEGRITY_FAIL;
+		cause = "untrusted-filesystem";
+		integrity_audit_msg(AUDIT_INTEGRITY_DATA, inode, filename,
+				    op, cause, rc, 0);
+	} else if (status != INTEGRITY_PASS) {
 		if ((ima_appraise & IMA_APPRAISE_FIX) &&
 		    (!xattr_value ||
  		     xattr_value->type != EVM_IMA_XATTR_DIGSIG)) {

And somewhere in the fuse mount code it would say:

	if (sb->s_user_ns != &init_user_ns)
        	sb->s_iflags |= SB_I_NOIMA);

The point being that the logic for setting the flag can live in fuse or
a simpler filesystem and all ima proper needs to do is deal with the flag being
set.  That should be easier to maintainer and simpler to code all
around.

Eric

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
