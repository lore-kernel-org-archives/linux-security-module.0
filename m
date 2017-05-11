From: rgb@redhat.com (Richard Guy Briggs)
Date: Thu, 11 May 2017 16:42:39 -0400
Subject: [RFC PATCH V2 0/4] capabilities: do not audit log BPRM_FCAPS on set*id
Message-ID: <cover.1494527628.git.rgb@redhat.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

The audit subsystem is adding a BPRM_FCAPS record when auditing setuid
application execution (SYSCALL execve). This is not expected as it was
supposed to be limited to when the file system actually had capabilities
in an extended attribute.  It lists all capabilities making the event
really ugly to parse what is happening.  The PATH record correctly
records the setuid bit and owner.  Suppress the BPRM_FCAPS record on
set*id.

See: https://github.com/linux-audit/audit-kernel/issues/16

The patch that resolves this issue is the third.  The first and second just
massage the logic to make it easier to understand.

It would be possible to address the original issue with a change of
	"!uid_eq(new->euid, root_uid) || !uid_eq(new->uid, root_uid)"
to
	"!(uid_eq(new->euid, root_uid) || uid_eq(new->uid, root_uid))"
but it took me long enough to understand this logic that I don't think I'd be
doing any favours by leaving it this difficult to understand.

The final patch attempts to address all the conditions that need logging based
on mailing list conversations, recoginizing there is probably some duplication
in the logic, which is why I'm posting this as an RFC for some feedback.

Richard Guy Briggs (4):
  capabilities: use macros to make the logic easier to follow and
    verify
  capabilities: invert logic for clarity
  capabilities: fix logic for effective root or real root
  capabilities: auit log other surprising conditions

 security/commoncap.c |   55 ++++++++++++++++++++++++++++++++-----------------
 1 files changed, 36 insertions(+), 19 deletions(-)

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
