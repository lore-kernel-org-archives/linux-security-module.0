From: nicolas@belouin.fr (nicolas at belouin.fr)
Date: Sat, 21 Oct 2017 21:09:32 +0200
Subject: [RFC PATCH 1/2] security, capabilities: create CAP_TRUSTED
In-Reply-To: <20171021160302.GA2842@mail.hallyn.com>
References: <20171021134558.21195-1-nicolas@belouin.fr>
	<20171021160302.GA2842@mail.hallyn.com>
Message-ID: <201710211909.v9LJ9Zg8033866@smtp6.infomaniak.ch>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

<james.l.morris@oracle.com>,linux-ext4 at vger.kernel.org,linux-kernel at vger.kernel.org,linux-f2fs-devel at lists.sourceforge.net,linux-fsdevel at vger.kernel.org,linux-mtd at lists.infradead.org,jfs-discussion at lists.sourceforge.net,ocfs2-devel at oss.oracle.com,linux-unionfs at vger.kernel.org,reiserfs-devel at vger.kernel.org,linux-security-module at vger.kernel.org,selinux at tycho.nsa.gov,linux-api at vger.kernel.org,kernel-hardening at lists.openwall.com
From: Nicolas Belouin <nicolas@belouin.fr>
Message-ID: <99179B10-4EAE-4FAB-9D14-B885156261B3@belouin.fr>



On October 21, 2017 6:03:02 PM GMT+02:00, "Serge E. Hallyn" <serge@hallyn.com> wrote:
>Quoting Nicolas Belouin (nicolas at belouin.fr):
>> with CAP_SYS_ADMIN being bloated, the usefulness of using it to
>> flag a process to be entrusted for e.g reading and writing trusted
>> xattr is near zero.
>> CAP_TRUSTED aims to provide userland with a way to mark a process as
>> entrusted to do specific (not specially admin-centered) actions. It
>> would for example allow a process to red/write the trusted xattrs.
>
>You say "for example".  Are you intending to add more uses?  If so,
>what
>are they?  If not, how about renaming it CAP_TRUSTED_XATTR?
>

I don't see any other use for now, but I don't want it to be too narrow and non usable in a similar context in the future. So I believe the underlying purpose of marking a process as "trusted" (even if for now it only means rw permission on trusted xattr) is more meaningful.

>What all does allowing writes to trusted xattrs give you?  There are
>the overlayfs whiteouts, what else?

Nicolas
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
