From: gilad@benyossef.com (Gilad Ben-Yossef)
Date: Wed, 18 Oct 2017 08:00:33 +0100
Subject: [PATCH v10 01/20] crypto: change transient busy return code to -ENOSPC
In-Reply-To: <1508310057-25369-1-git-send-email-gilad@benyossef.com>
References: <1508310057-25369-1-git-send-email-gilad@benyossef.com>
Message-ID: <1508310057-25369-2-git-send-email-gilad@benyossef.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

The crypto API was using the -EBUSY return value to indicate
both a hard failure to submit a crypto operation into a
transformation provider when the latter was busy and the backlog
mechanism was not enabled as well as a notification that the
operation was queued into the backlog when the backlog mechanism
was enabled.

Having the same return code indicate two very different conditions
depending on a flag is both error prone and requires extra runtime
check like the following to discern between the cases:

	if (err == -EINPROGRESS ||
	    (err == -EBUSY && (ahash_request_flags(req) &
			       CRYPTO_TFM_REQ_MAY_BACKLOG)))

This patch changes the return code used to indicate a crypto op
failed due to the transformation provider being transiently busy
to -ENOSPC.

Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
---
 crypto/algapi.c | 6 ++++--
 crypto/cryptd.c | 4 +---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/crypto/algapi.c b/crypto/algapi.c
index aa699ff..60d7366 100644
--- a/crypto/algapi.c
+++ b/crypto/algapi.c
@@ -897,9 +897,11 @@ int crypto_enqueue_request(struct crypto_queue *queue,
 	int err = -EINPROGRESS;
 
 	if (unlikely(queue->qlen >= queue->max_qlen)) {
-		err = -EBUSY;
-		if (!(request->flags & CRYPTO_TFM_REQ_MAY_BACKLOG))
+		if (!(request->flags & CRYPTO_TFM_REQ_MAY_BACKLOG)) {
+			err = -ENOSPC;
 			goto out;
+		}
+		err = -EBUSY;
 		if (queue->backlog == &queue->list)
 			queue->backlog = &request->list;
 	}
diff --git a/crypto/cryptd.c b/crypto/cryptd.c
index 0508c48..bd43cf5 100644
--- a/crypto/cryptd.c
+++ b/crypto/cryptd.c
@@ -137,16 +137,14 @@ static int cryptd_enqueue_request(struct cryptd_queue *queue,
 	int cpu, err;
 	struct cryptd_cpu_queue *cpu_queue;
 	atomic_t *refcnt;
-	bool may_backlog;
 
 	cpu = get_cpu();
 	cpu_queue = this_cpu_ptr(queue->cpu_queue);
 	err = crypto_enqueue_request(&cpu_queue->queue, request);
 
 	refcnt = crypto_tfm_ctx(request->tfm);
-	may_backlog = request->flags & CRYPTO_TFM_REQ_MAY_BACKLOG;
 
-	if (err == -EBUSY && !may_backlog)
+	if (err == -ENOSPC)
 		goto out_put_cpu;
 
 	queue_work_on(cpu, kcrypto_wq, &cpu_queue->work);
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
