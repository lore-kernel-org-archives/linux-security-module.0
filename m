From: james.l.morris@oracle.com (James Morris)
Date: Mon, 20 Nov 2017 08:42:11 +1100 (AEDT)
Subject: [GIT PULL] security subsystem: IMA bugfix
Message-ID: <alpine.LFD.2.20.1711200840190.25879@localhost>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

This fixes a long-standing bug in the IMA code.  Please pull.


The following changes since commit ed30b147e1f6e396e70a52dbb6c7d66befedd786:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/ide (2017-11-19 08:04:41 -1000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-integrity

for you to fetch changes up to 020aae3ee58c1af0e7ffc4e2cc9fe4dc630338cb:

  ima: do not update security.ima if appraisal status is not INTEGRITY_PASS (2017-11-20 08:23:10 +1100)

----------------------------------------------------------------
Roberto Sassu (1):
      ima: do not update security.ima if appraisal status is not INTEGRITY_PASS

 security/integrity/ima/ima_appraise.c | 3 +++
 1 file changed, 3 insertions(+)

--- 

commit 020aae3ee58c1af0e7ffc4e2cc9fe4dc630338cb
Author: Roberto Sassu <roberto.sassu@huawei.com>
Date:   Tue Nov 7 11:37:07 2017 +0100

    ima: do not update security.ima if appraisal status is not INTEGRITY_PASS
    
    Commit b65a9cfc2c38 ("Untangling ima mess, part 2: deal with counters")
    moved the call of ima_file_check() from may_open() to do_filp_open() at a
    point where the file descriptor is already opened.
    
    This breaks the assumption made by IMA that file descriptors being closed
    belong to files whose access was granted by ima_file_check(). The
    consequence is that security.ima and security.evm are updated with good
    values, regardless of the current appraisal status.
    
    For example, if a file does not have security.ima, IMA will create it after
    opening the file for writing, even if access is denied. Access to the file
    will be allowed afterwards.
    
    Avoid this issue by checking the appraisal status before updating
    security.ima.
    
    Cc: stable at vger.kernel.org
    Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
    Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
    Signed-off-by: James Morris <james.l.morris@oracle.com>

diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index ec7dfa0..65fbcf3 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -320,6 +320,9 @@ void ima_update_xattr(struct integrity_iint_cache *iint, struct file *file)
 	if (iint->flags & IMA_DIGSIG)
 		return;
 
+	if (iint->ima_file_status != INTEGRITY_PASS)
+		return;
+
 	rc = ima_collect_measurement(iint, file, NULL, 0, ima_hash_algo);
 	if (rc < 0)
 		return;
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info@ http://vger.kernel.org/majordomo-info.html
