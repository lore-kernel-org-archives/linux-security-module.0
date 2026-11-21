Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795265451;
	b=QiSx5BDxTRuVekeJGHWfXioOIt+z7eWGf2mu6QTtw6gN1mG8aB2zxjClqpsK4qhsotcG
	 ABDDzffjapAQg94fVd4Q1EeSbgt4hnyh6YZgg9Nhm9TutIa+N2DXvWMLI5WnUR8BUPV3b
	 AUzgtgdIyMYbxWDsl1Gyt97TpYsVlrBMGWXQDzSR4ZOBaDLCv+CjddxzeD7/Kif70RGjZ
	 rYqjmct6rYyrTHu8T5X1bvUi95QOeTycH31JCtWpwtTeOMtEvx9EZ+4HtQ4MHII1NWtvX
	 EHd6KzXV/P/zMy6OOvq5MM7JqbL+PASLqp8kwDHzMw1LZjHS4rfIHrnBVcgSPjIpBsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795265451;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=a+JvEByhjl3Q0eRtUPeklA/fZjCl5bKRc9fdhPzK8Ac=;
	b=4eg+SWWRIGmuVI5LGfhZHrU9Lh8uQpIQoW8TR/2r6QI/mlC1AQpRQY3p5OP/gkE5knqu
	 5dPiiHm0fpBi2VHg0yMYws5BudOBQs3OF3vLLhkA8gowFjtjTq2rLSZlCNO19RXovQOlp
	 XtA/fT22m+qK9zfTMgKvkb72ExdaomTxYYO4rChS7iAM4rZGXfkoRdtNVXOr6RxqpK44W
	 BOX4rz3EJUgewpDLKaUOTHXWu2KuiHK2f9Z9sU9BG+jHvdsERbCfOR+SEQKNA/L8BlFTz
	 lDZeuGgBjfYkNfHdoOu9IjtLfm651NeWwO5LhArhJRxWbpPuzN1lvpx/T5RnRxrtcOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Imsir6fH;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07F1606A331
	for <linux-security-module@vger.kernel.org>; Sat, 21 Nov 2026 12:50:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D07F1606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Imsir6fH
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a35a60499eso14038235e9.0
        for <linux-security-module@vger.kernel.org>; Sat, 21 Nov 2026 04:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795265449; x=1795870249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=a+JvEByhjl3Q0eRtUPeklA/fZjCl5bKRc9fdhPzK8Ac=;
        b=Imsir6fH8V7hOExu52NV554HH3pwtbhoLh70BMUw8H1FaFiWt7W9gMtzLxzyAWqEK7
         PDd4FwlbIR16ulmMWV/RrrEnkjme74mNISBwO15zVGJctYBCbuEexnAVhvDw7EChJweE
         CNJLlHu9Ia5dmdb8RBOiBLwhc4OjapiV+Cd5c2mU4ujK3opQq7DLiS0fxDOUOEmQUNcn
         Oc/JxNmuUt/GSKQYXe7LuWKLqWlVmLBpBDpHOHXdMcuoVtBhj0Cs7C48GQHHVRpGJLnx
         57FfYipZk9L0sk23f1CityQxeUziuI/F0K8U0AB14i0DdHS5Ft9RaNWxa8xeiGMaq5aa
         bU8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795265449; x=1795870249;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=a+JvEByhjl3Q0eRtUPeklA/fZjCl5bKRc9fdhPzK8Ac=;
        b=QP0Cwz3rju030FcLPVotcbD2waUl/rOpfaspXhg4C4h1RtSU9Pyhra20S032HkaH/i
         vjl4nZQ8AwNc2u8P6sc03qCyt19wK+m12VgQXv0ePbCnRkkb7oQ5PahX/5xCfA/qXkqy
         G/TLVyKpigbiDPmmRE79sMs/LKaywyaN4BqOiLozXo/bXpnJYf+qpiHMDYYRes74WaNg
         5jsF+0YS8y1jwkbvUAalbiKwpuQzcrGewMGDHU9M4QQP9pPS/9MlX04yj7CJs0kt/Nt8
         Ay4bazlxnUryFOgsu6sTyefaqkgkzK0HvzLO3S3Bw8TuW2vspEZycfe9UOV2wPm1v01w
         srAA==
X-Forwarded-Encrypted: i=1; AL+hErGmI7VonRcaTtxv6NBjRMRrYsoN2D1KMND4yhsicGQ+UHhYWyy9EL10iK7rOUWRis92KALYjP7Q9oc66gNJPTU+vBmGvNU=@vger.kernel.org
X-Gm-Message-State: APuU4Z87YdTr9zHxDR5WtBlykcX/RnlGA6pHt6NcMf5IuxcQR9A7xQr3
	YqmNhkyiofx6/efyMs74eyBeTp/czd7FbnX5CvR7tCPQYq/LQua/RFA=
X-Gm-Gg: AZFdTZdtNz9HDLqHtAcAH0g0g/e1LS1RHDqJ1S5rO9GYoXe+JfJfOLJ3ndIYVHZCphE
	4/KkFSPgJL5Oux63SvTN++Q+WbzqwgcFoOExOhwZ+ooBha2MRcdzeh5lY80CjNwyZbe4P6oGlTJ
	dpMolUlGjS5O/rEgXUmqTQ7PmmWgcAU+p/dY6rpCm57Uo+DmISx1ct7Din20YkxLjo2zJGuL7sA
	k7k7/6giCusPJaNN9bhKKxyN6U4dAmnwOLIsiKPJsoTSRFs6g10GO7iyzm+iMUQJ2KkS61McEaV
	Y7CqWu+FOsKi5AtQe11ZObak1AOg691MasQOIYmNWgXvesuQqpFGkIoneIJhevqrVEH5ApDK/rb
	VpdwuA+WzffLqt0joZH7jQtpSxZFaeO3lg7zjKPNuUZX0TCZRUcrRFthVXToIFjxbFV5/ZXZASr
	FcT6DyXzYmXKRwzfDN05+h+iJktcbsAt36IHY43lSrSW86c29HxdOJNzJ1o7x1rZNa1OeWRkCLu
	cJvs2hef5Mtx+hJOYbAPznYUJhZ96bIHcmZOx5dpYXwZnotnt3ECzAE04WslefwCbtsOd1XyZow
	1jkVtwcuu1iXUVqv8sKZTUA+Jtgnnp3fmABS
X-Received: by 2002:a05:600c:820d:b0:4bb:6cef:d14b with SMTP id 5b1f17b1804b1-4bb887c34f1mr145440935e9.2.1795265448967;
        Sat, 21 Nov 2026 04:50:48 -0800 (PST)
Received: from localhost.localdomain ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab69bf685asm10803003f8f.20.2026.11.21.04.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 04:50:48 -0800 (PST)
From: Tristan Madani <tristmd@gmail.com>
To: David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] KEYS: protect construct_key type dereference with key semaphore
Date: Sat, 21 Nov 2026 12:50:39 +0000
Message-ID: <20261121125039.2532663-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tristan Madani <tristan@talencesecurity.com>

construct_key() reads key->type->request_key without holding key->sem,
then calls the resulting actor function pointer.  While the
sys_request_key() syscall path holds key_types_sem for reading (via
key_type_lookup()), which prevents concurrent type removal, in-kernel
request_key() callers pass struct key_type directly without holding
key_types_sem.  If unregister_key_type() races with such a caller,
key_garbage_collector() can retype the key to key_type_dead and the
module text backing the original request_key method can be freed before
the actor call executes.

Take key->sem for reading around both the key->type->request_key lookup
and the actor() call, consistent with the approach used by 925c84e3cc21
("KEYS: Protect the read method check against type removal"),
51bcd09b9ffc ("KEYS: Protect the update method check against type
removal") and bab48a104447 ("KEYS: Protect the pkey method checks
against type removal") which protect analogous method dereferences in
the keyctl paths.

Fixes: b5f545c880a2 ("[PATCH] keys: Permit running process to instantiate keys")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
Changes in v2:
- Hold key->sem across the actor() call, not just the type pointer read,
  matching the established pattern from the three prior fixes (Sashiko)
- Clarify that in-kernel request_key() callers do not hold key_types_sem
  so the race is reachable outside the syscall path (Sashiko)

 security/keys/request_key.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/security/keys/request_key.c b/security/keys/request_key.c
index 22cd66a44da56..60a8cb5924e11 100644
--- a/security/keys/request_key.c
+++ b/security/keys/request_key.c
@@ -241,10 +241,12 @@ static int construct_key(struct key *key, const void *callout_info,
 
 	/* Make the call */
 	actor = call_sbin_request_key;
+	down_read(&key->sem);
 	if (key->type->request_key)
 		actor = key->type->request_key;
 
 	ret = actor(authkey, aux);
+	up_read(&key->sem);
 
 	/* check that the actor called complete_request_key() prior to
 	 * returning an error */
-- 
2.47.3

