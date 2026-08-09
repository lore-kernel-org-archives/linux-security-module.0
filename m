Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EBF5156661
	for <linux-security-module@vger.kernel.org>; Sun,  9 Aug 2026 11:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786273330; cv=none; b=VsSsCB+k1aYXOYUhQT2PSF1NIZLpI7ZAjoZ0VflNj3VBwv17qkkScpeVj4iXaYv41fx8yc6NLJYrNSDZ7W2WnEy6Xc9M86/iaGCfrlzrFaKbfGLmgjaDyYv+W4Oalb0zUHClWI86YB888JIBvDcHQVShXPglHV09SabHYuNIrW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786273330; c=relaxed/simple;
	bh=ywo2uPUsrXTAwO9InRinXm5M+tv6nKvz6B/hC03eifw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FS4SIUuvQIZecYDdF9NLT/Ce4/aKX3AyKneD/dLkgNavkn5mTfj3f8nijg/iz0GAQ45G6BHYsnUHPvvkbapNtYcdO3758pg3tseVq8B4OVz+jblZMFZq6I9cQ+IFlsdENcP53T7v286gIcCHOMjUlloyxo2XBFZpcZR9KKiu5Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xvz0xoIW; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xvz0xoIW"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2cc97653887so10437765ad.1
        for <linux-security-module@vger.kernel.org>; Sun, 09 Aug 2026 04:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786273327; x=1786878127; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sc5V86l7BdE/6kSiloB+tbkV9FHRrzjo44RFbsUV2/g=;
        b=Xvz0xoIWRAL+Wc2Va+lLI7kmPCSQcPi7IioXYJh5jdLTS4OOGoLm4UOTEBvCeXWNE+
         LNxNRYttMozn9H/5h1p3+8L05mremCxaqPeLCT7veIYzl3a4mArWw02iJUUgHP7ZgH/D
         J/CecEjkj8mNhf2rPRkmGiK2+yPJ7CwtA3DKncRkjmWBBK1Vcpx41UI6WIx36LopCph/
         uZgUo9lrn8r+iZeEr8H3vyAWVTgvlX3+hxwFAAnVRTvX0zz0WvWbOhi8b/RtLEp33ICE
         5B9Q0hhwmlZyW20CAcHv4+V9dJNEO/oCIha/WYGfaBWjrurJ5ZBI3MXGavpUTI0/Suvo
         2Kjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786273327; x=1786878127;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sc5V86l7BdE/6kSiloB+tbkV9FHRrzjo44RFbsUV2/g=;
        b=ks73xBrpf91sSsx4B/xHnmsuBJWkRIInULfe62gdu99VMC3L0k5o10LTKFeCUvpte9
         eWYaCG6wZC6Fo2y9tnTYGKixhtB7PBaRRokzlmQy6bzVX7VHMcm5L9oa5EYF6XapOG3+
         ABjjiqW5a9CDVv8kmIGSJMVo3pH4fD5G4iFepqD3DRE0ngvWEWDlikVfyO5M8p92kZ/f
         XCxu0uj8TK8Rtnsb9k6FPfiNIlQF2JnsGjiIroP7PMf0P8KLm9IuhWzxEY/7BQUk7cnr
         NGQYjIBuEUF8o4KntvB4laqlgcLaSyk3kSMlj7g5fZUcI3/sW85Zuniv9JT22FqptKwo
         XYhA==
X-Forwarded-Encrypted: i=1; AHgh+Rq4tjLtmTlWMTeIxM3i1CGyn1RvC/eUwkfb6WRvKUqbkLaEStdeR9R5+aNULq06MKK2fpodeOgXiKqH26cY+FAfy68zfCE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy54v0hbcQbb2OI45JtRpE9np6n4cDLWg9UGKZc2fZUnutup93r
	4dnZ/RcwifE/fHNbpJ7uFMAdD3EOgDSkuchP2qJwU51gtKTf1RGWPCiS3w1nHA==
X-Gm-Gg: AR+sD12WkrAV9YcrJopk4P3wb5hpxi+4GMlXs8EEqesfUEl5EcDzU7ix6cfIcF+7OrU
	noxL42EVOOF/onfhhj8k4xvK6bx1z6fWS4VYOoYLB937r/7rGTU6EajBNPvFVgkk7SvZmCDaTnO
	Cc0JErdOa+SoNXFHSH3ZGp98SoxEJ0AZ1/yoXvIPC02IbwNdf3cEoTcZ8kpZv58jEmMfkaYXZkx
	qX1tcVVMjx8UOCO3yitxp9kUm5SkJlKcqRwoV9MHxak7a8wTPis8WviDHadkJEay87zCn+N+NjK
	393rhLBFzQuyD5B4s/tvvILZdZXbEaKimPDqpspND8n7vuZhrUnF2ziapAqU+5fqy0u7Okaf8QC
	fL+hKgPAz8o86TC4vciuEzza8aFRcMCeBtmlBMea7ND2P12A0sYpSIer3eNmpjPIQdZAvsgLTwd
	3h0GZFrjjY7T4xhaUi+ywDGKVvKJumOvpvjFeN/8Hda+/zdeJrPk4q8T3DsrpVOvXF1U/QTcxKx
	Oe7a6PT+jE2rHg76MumW8NL
X-Received: by 2002:a17:90b:46:b0:38e:67e1:15b with SMTP id 98e67ed59e1d1-3903c5363a5mr39906893a91.6.1786273327417;
        Sun, 09 Aug 2026 04:02:07 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315beb88413sm50247194eec.18.2026.08.09.04.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 04:02:06 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: keys: request_key_auth shows a global pid in /proc/keys across pid namespaces
Date: Sun,  9 Aug 2026 19:02:02 +0800
Message-Id: <20260809110202.2180410-1-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

I think request_key_auth leaks a global pid into /proc/keys. I would
appreciate it if you could take a look.

request_key_auth_describe() prints the requestor's pid:

	if (key_is_positive(key))
		seq_printf(m, " pid:%d ci:%zu", rka->pid, rka->callout_len);

rka->pid is current->pid, captured in request_key_auth_new() when the
auth key is made. It is a raw pid_t in the init pid namespace. But
/proc/keys is read by whoever opens it, and their pid namespace can
differ. The uid and gid on that line already go through seq_user_ns(m).
The pid does not. So a reader in another pid namespace gets a number
that means nothing there, or worse lands on a different task.

Not everyone can read the line. The owner uid must map into the reader's
user namespace, and the reader needs VIEW on the key. The auth key gives
VIEW to the requestor's own uid and to a possessor. So the reader has to
be the requestor's uid, in a different pid namespace. That fits a
sandbox at the same uid, made with unshare, systemd-nspawn or
bubblewrap. A default Docker container does not hit it, since it hides
/proc/keys.

I found this with a static check for ids that reach userspace with no
namespace translation. I reproduced it in a qemu VM on 7.1-rc1 as a
normal user, no hardware or kernel changes needed. The reproducer calls
request_key, then reads /proc/keys from a sibling pid namespace. Before
the patch it reads the requestor's global pid, which does not exist in
that namespace. After the patch it reads pid 0, since the requestor has
no pid there. There is no keyrings selftest in the tree, so this is the
only test.

I am happy to send a patch. The raw pid_t cannot be translated later. So
I stored a struct pid and print it with pid_nr_ns, the way the uid is
already scoped.

Thanks,
Maoyi
https://maoyixie.com/

---

diff --git a/include/keys/request_key_auth-type.h b/include/keys/request_key_auth-type.h
index 01e42ee5f4099..464636278c4f8 100644
--- a/include/keys/request_key_auth-type.h
+++ b/include/keys/request_key_auth-type.h
@@ -22,7 +22,7 @@ struct request_key_auth {
 	const struct cred	*cred;
 	void			*callout_info;
 	size_t			callout_len;
-	pid_t			pid;
+	struct pid		*pid;
 	char			op[8];
 } __randomize_layout;
 
diff --git a/security/keys/request_key_auth.c b/security/keys/request_key_auth.c
index 282e09d8fa46c..e8d1037526b19 100644
--- a/security/keys/request_key_auth.c
+++ b/security/keys/request_key_auth.c
@@ -13,6 +13,8 @@
 #include <linux/slab.h>
 #include <linux/uaccess.h>
 #include "internal.h"
+#include <linux/pid_namespace.h>
+#include <linux/proc_fs.h>
 #include <keys/request_key_auth-type.h>
 
 static int request_key_auth_preparse(struct key_preparsed_payload *);
@@ -73,7 +75,10 @@ static void request_key_auth_describe(const struct key *key,
 	seq_puts(m, "key:");
 	seq_puts(m, key->description);
 	if (key_is_positive(key))
-		seq_printf(m, " pid:%d ci:%zu", rka->pid, rka->callout_len);
+		seq_printf(m, " pid:%d ci:%zu",
+			   pid_nr_ns(rka->pid,
+				     proc_pid_ns(file_inode(m->file)->i_sb)),
+			   rka->callout_len);
 }
 
 /*
@@ -113,6 +118,7 @@ static void free_request_key_auth(struct request_key_auth *rka)
 	if (rka->cred)
 		put_cred(rka->cred);
 	kfree(rka->callout_info);
+	put_pid(rka->pid);
 	kfree(rka);
 }
 
@@ -226,14 +232,14 @@ struct key *request_key_auth_new(struct key *target, const char *op,
 
 		irka = cred->request_key_auth->payload.data[0];
 		rka->cred = get_cred(irka->cred);
-		rka->pid = irka->pid;
+		rka->pid = get_pid(irka->pid);
 
 		up_read(&cred->request_key_auth->sem);
 	}
 	else {
 		/* it isn't - use this process as the context */
 		rka->cred = get_cred(cred);
-		rka->pid = current->pid;
+		rka->pid = get_pid(task_pid(current));
 	}
 
 	rka->target_key = key_get(target);
