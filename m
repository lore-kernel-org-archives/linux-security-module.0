From: dhowells@redhat.com (David Howells)
Date: Wed, 05 Apr 2017 21:17:45 +0100
Subject: [PATCH 22/24] Prohibit PCMCIA CIS storage when the kernel is locked
	down
In-Reply-To: <149142326734.5101.4596394505987813763.stgit@warthog.procyon.org.uk>
References: <149142326734.5101.4596394505987813763.stgit@warthog.procyon.org.uk>
Message-ID: <149142346534.5101.3176119517193928628.stgit@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Prohibit replacement of the PCMCIA Card Information Structure when the
kernel is locked down.

Suggested-by: Dominik Brodowski <linux@dominikbrodowski.net>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-pcmcia at lists.infradead.org
---

 drivers/pcmcia/cistpl.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pcmcia/cistpl.c b/drivers/pcmcia/cistpl.c
index 55ef7d1fd8da..193e4f7b73b1 100644
--- a/drivers/pcmcia/cistpl.c
+++ b/drivers/pcmcia/cistpl.c
@@ -1578,6 +1578,11 @@ static ssize_t pccard_store_cis(struct file *filp, struct kobject *kobj,
 	struct pcmcia_socket *s;
 	int error;
 
+	if (kernel_is_locked_down()) {
+		pr_err("Direct CIS storage isn't permitted when the kernel is locked down\n");
+		return -EPERM;
+	}
+
 	s = to_socket(container_of(kobj, struct device, kobj));
 
 	if (off)

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
