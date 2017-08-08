From: gilad@benyossef.com (Gilad Ben-Yossef)
Date: Tue,  8 Aug 2017 15:03:33 +0300
Subject: [PATCH v4 02/19] crypto: ccm: use -EAGAIN for transient busy
	indication
In-Reply-To: <1502193834-11289-1-git-send-email-gilad@benyossef.com>
References: <1502193834-11289-1-git-send-email-gilad@benyossef.com>
Message-ID: <1502193834-11289-3-git-send-email-gilad@benyossef.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Replace -EBUSY with -EAGAIN when reporting transient busy
indication in the absence of backlog.

Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
---
 drivers/crypto/ccp/ccp-crypto-main.c | 8 +++-----
 drivers/crypto/ccp/ccp-dev.c         | 7 +++++--
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/crypto/ccp/ccp-crypto-main.c b/drivers/crypto/ccp/ccp-crypto-main.c
index 35a9de7..403ff0a 100644
--- a/drivers/crypto/ccp/ccp-crypto-main.c
+++ b/drivers/crypto/ccp/ccp-crypto-main.c
@@ -222,9 +222,10 @@ static int ccp_crypto_enqueue_cmd(struct ccp_crypto_cmd *crypto_cmd)
 
 	/* Check if the cmd can/should be queued */
 	if (req_queue.cmd_count >= CCP_CRYPTO_MAX_QLEN) {
-		ret = -EBUSY;
-		if (!(crypto_cmd->cmd->flags & CCP_CMD_MAY_BACKLOG))
+		if (!(crypto_cmd->cmd->flags & CCP_CMD_MAY_BACKLOG)) {
+			ret = -EAGAIN;
 			goto e_lock;
+		}
 	}
 
 	/* Look for an entry with the same tfm.  If there is a cmd
@@ -243,9 +244,6 @@ static int ccp_crypto_enqueue_cmd(struct ccp_crypto_cmd *crypto_cmd)
 		ret = ccp_enqueue_cmd(crypto_cmd->cmd);
 		if (!ccp_crypto_success(ret))
 			goto e_lock;	/* Error, don't queue it */
-		if ((ret == -EBUSY) &&
-		    !(crypto_cmd->cmd->flags & CCP_CMD_MAY_BACKLOG))
-			goto e_lock;	/* Not backlogging, don't queue it */
 	}
 
 	if (req_queue.cmd_count >= CCP_CRYPTO_MAX_QLEN) {
diff --git a/drivers/crypto/ccp/ccp-dev.c b/drivers/crypto/ccp/ccp-dev.c
index 4e029b1..3d637e3 100644
--- a/drivers/crypto/ccp/ccp-dev.c
+++ b/drivers/crypto/ccp/ccp-dev.c
@@ -292,9 +292,12 @@ int ccp_enqueue_cmd(struct ccp_cmd *cmd)
 	i = ccp->cmd_q_count;
 
 	if (ccp->cmd_count >= MAX_CMD_QLEN) {
-		ret = -EBUSY;
-		if (cmd->flags & CCP_CMD_MAY_BACKLOG)
+		if (cmd->flags & CCP_CMD_MAY_BACKLOG) {
+			ret = -EBUSY;
 			list_add_tail(&cmd->entry, &ccp->backlog);
+		} else {
+			ret = -EAGAIN;
+		}
 	} else {
 		ret = -EINPROGRESS;
 		ccp->cmd_count++;
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
