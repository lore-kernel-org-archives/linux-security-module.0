Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8DA3F44F4
	for <linux-security-module@vger.kernel.org>; Mon,  7 Sep 2026 21:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788814831; cv=none; b=ZnxCMkDwLSlWooXSr0Weh0vszPJvUt3+QqD7gg0epSk6/E+1Q8ESF2EQwbetm6GSgafdlxwhXNG+OzP3dxubXOS4CfEa746eOPiIqQw6ak05RYbGO22i9y8tvbcQGzYKnRid8jPCIrexAjCYeSE9Qgb3/ZZgjeF2boEw25Rfha0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788814831; c=relaxed/simple;
	bh=nXhPP7b+pyPXaxP9+90HyfAUpFQfbnZ7QKkr8iKuqZM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i+sY3CczTwI5EKjEx9zTmXEwzrv1h16d9ulM7mJk1eqzh9iSNBWkSVhKtqYDeUhcdzwcK01ExNQdAVxNVrnYH/VeIKpYQ4tO0HeK/bzC+Ylw90edoG0aCJzC2rRCHv0kvVuRVARKLnweHBtVQBR5eknQcwJx2ObXKopy7BdkZ+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UExz0H7L; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UExz0H7L"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49cda5e048fso87265e9.0
        for <linux-security-module@vger.kernel.org>; Mon, 07 Sep 2026 14:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788814827; x=1789419627; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iQCLFONZFsqSS9MwFNZTsRaivhIEdBav9Smp5SCcRdQ=;
        b=UExz0H7Liw3n0dAgTccqu7Au/eOEQ1aYy6b9xat9MWebk6RLBZUn08n3uyRXdsJ8pW
         OWmBmPM9/Mk1QmRWay0aLS7RSD4TOrWCCnYxyIySNTEB6NgMeOz9cvl1dpTDDbwrW0rc
         3Vv4pkoCVXykDBftnTNbPEKAfUrseLawqnjcTXxZSmXImP+qn+CswhyAJVwbaHnQtoxB
         Era/GuJRdOhtPg7y7/9nVf903xWGTs9ojmAVVP/SQXRcbbH6o8Ad+n9QAtY6qYp8Von8
         cwesLHG+ALjBPx75cxBGswcy3gKKKBY3NiYDz6p/EB0O1YmLwQ1LbolIimy9mXW3QRx2
         /NQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788814827; x=1789419627;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iQCLFONZFsqSS9MwFNZTsRaivhIEdBav9Smp5SCcRdQ=;
        b=QLnX4B5+OHOuz3ZqXJe0+S2qEFxGJtsNFq/meV97PW0QzVg4Pt+711MhBDti0qvzfc
         YOaGBmzuut90xQPuwArT+P2W94+dW/fd3bX9ALjMZC+sF8E0jIHqePTQFIk1HpFXpVL3
         YiHs87+gcW8mtOKvKKRA56R6ft9DH2H0ncifMUJgwqZ8qHgFHyhZAlIvmXClRg2E+WW5
         EwYTE1V3g1SMsOk4hqXPdVrVMUs7QglD4mYGffVPsVNz0acoAMmjM+n8ACHj7Y6FOBoQ
         nmrir+vWauykIi/BYiCNpIRp2FudUQIiSlEGyN7kDrVNYc9Q4uKR0yFQUJk2Xxtb6CKr
         AMTQ==
X-Forwarded-Encrypted: i=1; AKwUvBw5KpPys16q5eO4TK0QgingyCvbnTaGbCbedEIAYTWj2cg6JEqddXbie00f4gRqn1KgpnNJ8pToBZXuWj7qwTlEkoP5j/g=@vger.kernel.org
X-Gm-Message-State: AFuF++m5kumYIQzqThVqlwDFpl+dO1Q6XzIjWDjMsK36CXcYCIl9OUqJ
	kzF3zqmqknr8Jsh9DNb5hnRpF6cBhfXS6xppEZAHg/bIwAzb9VdWRWFCLL4302wSrg==
X-Gm-Gg: AYBFou0bcPG5/W0Is5YDob25Gl8A/IymqcYLkuXyWRZhv9cbbCSxhR0ywqOm+yPDg36
	zcDLbWFjATeKOWt38aUWgsLY5geUActOtOKIu5w/3fVErJrDcXeQG6DzTge4YvF8EDtH4SV+fcK
	MyUlF//81PaD9qFLTnla4uRvtDXIILj+OBoTC+wT3ITUuBroyjrhdh7MLBatYMMYR6juSqOhCik
	8WUQ4Vo17AdQYwdp9XwqbPImoROqnflQUtaRtfI+DfSZktTFciPfAhTJR6ZcB9wj9HU3Lz1Ar1J
	JEuSx9hpvQl0KW492ZhmC5xYmW9aseKTrYRDhJhbFp56B6Lm/ZcvK/BrKMHvNoQUEOq0Bam+K/U
	FQ0sWxOFpbQ9buBn5c2MQUEFIMPSHch2wlJOL2K3T98O9qw6e4ZbVsC41XAzel+3ZaytX+ebM1M
	AmumlbshZqlLxRShBVubwZ8/o0A9RRCDroEDoe/lasmvjrv/2WlSLh8l/8HJPvTY+n1/DfbFgSQ
	kHe5ev+vgXkouAvycEQ8BrEWxGAv/+WNNf6Bfglzb1eNazm
X-Received: by 2002:a05:600c:6a97:b0:49c:e41a:4c70 with SMTP id 5b1f17b1804b1-49d0918770cmr1429165e9.6.1788814826565;
        Mon, 07 Sep 2026 14:00:26 -0700 (PDT)
Received: from localhost ([2a00:79e0:288a:8:437c:9ac6:4a41:e58b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cff8195ffsm284349545e9.14.2026.09.07.14.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 14:00:25 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Date: Mon, 07 Sep 2026 23:00:16 +0200
Subject: [PATCH v3 1/3] proc: refactor /proc/$pid/mem to use struct as
 private_data
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-selinux-pokemem-v3-1-0bafbaeafe50@google.com>
References: <20260907-selinux-pokemem-v3-0-0bafbaeafe50@google.com>
In-Reply-To: <20260907-selinux-pokemem-v3-0-0bafbaeafe50@google.com>
To: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
 "Serge E. Hallyn" <serge@hallyn.com>, 
 Stephen Smalley <stephen.smalley.work@gmail.com>, 
 Jeff Xu <jeffxu@google.com>, 
 =?utf-8?q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
 Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org, 
 Andrew Morton <akpm@linux-foundation.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Pedro Falcato <pfalcato@suse.de>, 
 David Hildenbrand <david@kernel.org>, linux-mm@kvack.org, 
 Jann Horn <jannh@google.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788814820; l=2509;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=nXhPP7b+pyPXaxP9+90HyfAUpFQfbnZ7QKkr8iKuqZM=;
 b=TjH93s5viiCaqbVla2fILw+6iavAeMoHXtJBogMiukSdNz0HlukgBb+TDYrU3XHWPX6nl+Ot9
 pD4MowbEkJcBFfFenw8ptozqsSCQUPqx8gGuKY+Ky6uiXYzKNt3+1wC
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=

Refactor the handlers for proc_mem_operations to use the new struct
mem_private as ->private_data, rather than directly storing an mm_struct*
in ->private_data.

This is in preparation for adding more state in mem_private in the next
commit.

Reviewed-by: Jan Kara <jack@suse.cz>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Signed-off-by: Jann Horn <jannh@google.com>
---
 fs/proc/base.c | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 780f81259052..bec6197329dc 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -848,11 +848,24 @@ static int __mem_open(struct inode *inode, struct file *file, unsigned int mode)
 	return 0;
 }
 
+/* private_data for proc_mem_operations */
+struct mem_private {
+	struct mm_struct *mm;
+};
+
 static int mem_open(struct inode *inode, struct file *file)
 {
+	struct mem_private *priv __free(kfree) = kmalloc_obj(struct mem_private);
+
+	if (!priv)
+		return -ENOMEM;
 	if (WARN_ON_ONCE(!(file->f_op->fop_flags & FOP_UNSIGNED_OFFSET)))
 		return -EINVAL;
-	return __mem_open(inode, file, PTRACE_MODE_ATTACH);
+	priv->mm = proc_mem_open(inode, PTRACE_MODE_ATTACH);
+	if (IS_ERR_OR_NULL(priv->mm))
+		return priv->mm ? PTR_ERR(priv->mm) : -ESRCH;
+	file->private_data = no_free_ptr(priv);
+	return 0;
 }
 
 static bool proc_mem_foll_force(struct file *file, struct mm_struct *mm)
@@ -880,7 +893,8 @@ static bool proc_mem_foll_force(struct file *file, struct mm_struct *mm)
 static ssize_t mem_rw(struct file *file, char __user *buf,
 			size_t count, loff_t *ppos, int write)
 {
-	struct mm_struct *mm = file->private_data;
+	struct mem_private *priv = file->private_data;
+	struct mm_struct *mm = priv->mm;
 	unsigned long addr = *ppos;
 	ssize_t copied;
 	char *page;
@@ -970,12 +984,21 @@ static int mem_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
+static int mem_release_with_private(struct inode *inode, struct file *file)
+{
+	struct mem_private *priv = file->private_data;
+
+	mmdrop(priv->mm);
+	kfree(priv);
+	return 0;
+}
+
 static const struct file_operations proc_mem_operations = {
 	.llseek		= mem_lseek,
 	.read		= mem_read,
 	.write		= mem_write,
 	.open		= mem_open,
-	.release	= mem_release,
+	.release	= mem_release_with_private,
 	.fop_flags	= FOP_UNSIGNED_OFFSET,
 };
 

-- 
2.55.0.1003.g10538fe699-goog

