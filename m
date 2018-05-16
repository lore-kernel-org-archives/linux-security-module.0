From: rgb@redhat.com (Richard Guy Briggs)
Date: Wed, 16 May 2018 07:55:44 -0400
Subject: [PATCH ghak81 V3 0/3] audit: group task params
Message-ID: <cover.1526430313.git.rgb@redhat.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Group the audit parameters for each task into one structure.
In particular, remove the loginuid and sessionid values and the audit
context pointer from the task structure, replacing them with an audit
task information structure to contain them.  Use access functions to
access audit values.

Use dynamic allocation of the audit task information structure employing
kmem_cache.  Static allocation has the limitation that future audit task
information structure changes would cause a visible change to the rest
of the kernel, whereas dynamic allocation would mostly hide any future
changes.

Passes audit-testsuite.

Changelog:
v3
- drop patches 2, 3, 4 already merged.
- fix for previous v2 patch 3 (seccomp get audit_context)
- dynamic audit_task_info allocation from kmem_cache
- fix assignment in if statement v2 patch 1 (normalize loginuid read)
- fix a number of merge conflicts/checkpatch
v2
- p2/5: add audit header to init/init_task.c to quiet kbuildbot
- audit_signal_info(): fetch loginuid once
- remove task_struct from audit_context() param list
- remove extra task_struct local vars
- do nothing on request to set audit context when audit is disabled

Richard Guy Briggs (3):
  audit: use new audit_context access funciton for
    seccomp_actions_logged
  audit: normalize loginuid read access
  audit: collect audit task parameters

 include/linux/audit.h | 34 ++++++++++++++++-------
 include/linux/sched.h |  5 +---
 init/init_task.c      |  3 +-
 init/main.c           |  2 ++
 kernel/auditsc.c      | 77 ++++++++++++++++++++++++++++++++++++++-------------
 kernel/fork.c         |  2 +-
 6 files changed, 87 insertions(+), 36 deletions(-)

-- 
1.8.3.1

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
