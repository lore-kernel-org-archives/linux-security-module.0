From: dhowells@redhat.com (David Howells)
Date: Tue, 21 Aug 2018 16:56:56 +0100
Subject: [PATCH 01/23] TPM: Add new TPMs to the tail of the list to prevent
	inadvertent change of dev
In-Reply-To: <153486700916.13066.12870860668352070081.stgit@warthog.procyon.org.uk>
References: <153486700916.13066.12870860668352070081.stgit@warthog.procyon.org.uk>
Message-ID: <153486701644.13066.13372706238885253812.stgit@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Add newly registered TPMs to the tail of the list, not the beginning, so that
things that are specifying TPM_ANY_NUM don't find that the device they're
using has inadvertently changed.  Adding a second device would break IMA, for
instance.

Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Signed-off-by: Peter Huewe <peterhuewe@gmx.de>
cc: stable at vger.kernel.org
---

 drivers/char/tpm/tpm-interface.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index 6af17002a115..cfb9089887bd 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -1122,7 +1122,7 @@ struct tpm_chip *tpm_register_hardware(struct device *dev,
 
 	/* Make chip available */
 	spin_lock(&driver_lock);
-	list_add_rcu(&chip->list, &tpm_chip_list);
+	list_add_tail_rcu(&chip->list, &tpm_chip_list);
 	spin_unlock(&driver_lock);
 
 	return chip;
