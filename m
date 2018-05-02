From: tyhicks@canonical.com (Tyler Hicks)
Date: Wed,  2 May 2018 15:53:16 +0000
Subject: [PATCH v2 0/4] Better integrate seccomp logging and auditing
Message-ID: <1525276400-7161-1-git-send-email-tyhicks@canonical.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Seccomp received improved logging controls in v4.14. Applications can opt into
logging of "handled" actions (SECCOMP_RET_TRAP, SECCOMP_RET_TRACE,
SECCOMP_RET_ERRNO) using the SECCOMP_FILTER_FLAG_LOG bit when loading filters.
They can also debug filter matching with the new SECCOMP_RET_LOG action.
Administrators can prevent specific actions from being logged using the
kernel.seccomp.actions_logged sysctl.

However, one corner case intentionally wasn't addressed in those v4.14 changes.
When a process is being inspected by the audit subsystem, seccomp's decision
making for logging ignores the new controls and unconditionally logs every
action taken except for SECCOMP_RET_ALLOW. This isn't particularly useful since
many existing applications don't intend to log handled actions due to them
occurring very frequently. This amount of logging fills the audit logs without
providing many benefits now that application authors have fine grained controls
at their disposal.

This patch set aligns the seccomp logging behavior for both audited and
non-audited processes. It also emits an audit record, if auditing is enabled,
when the kernel.seccomp.actions_logged sysctl is written to so that there's a
paper trail when entire actions are quieted.

Changes since v1:
* Patch 1
  - No changes
* Patch 2
  - New patch, allowing for a configurable separator between action names
* Patch 3
  - The value of the actions field in the audit record now uses a comma instead
    of a space
  - The value of the actions field in the audit record is no longer enclosed in
    quotes
  - audit_log_start() is called with the current processes' audit_context in
    audit_seccomp_actions_logged()
  - audit_seccomp_actions_logged() no longer records the pid, uid, auid, tty,
    ses, task context, comm, or executable path
  - The new and old value of seccomp_actions_logged is recorded in the
    AUDIT_CONFIG_CHANGE record
  - The value of the "res" field in the CONFIG_CHANGE audit record is corrected
    (1 indicates success, 0 failure)
  - Updated patch 3's commit message to reflect the updated audit record format
    in the examples
* Patch 4
  - A function comment for audit_seccomp() was added to explain, among other
    things, that event filtering is performed in seccomp_log()

Tyler

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
