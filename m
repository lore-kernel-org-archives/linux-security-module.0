Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C011C3B3C1D
	for <linux-security-module@vger.kernel.org>; Fri,  9 Oct 2026 05:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791522674; cv=none; b=aeKwo45JtmUN0zGyS+deb5vEclCaRRtaMU5VO+C7k4pKUr+Eg/5qEyl1H3fPcw/fKcE6lqwj9QM8dKqFoju620W3WkAFPhhyyFlsjAZnWlPz4j2fUp8b9hMSYoMQ3B2RZZSmXgGM2DXiWbca66kaslE3PGO3sFc/yKtm95vOi8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791522674; c=relaxed/simple;
	bh=fIG6kNVbSBDcIDJq3p3pVkq328vRxzchYU1SH8Kzvhw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=TmW52so4/ALyAR44+7l10TxOJBJBE+Eu18YnNVC0eGClC92u5Lnj0qMst9MziB2B6WLi2mcNUD4LfMtCvAT0fkIlJut703EOzHjN6A0e05WdoEmXMIoDw26ITQLjqfZ+SwsUCrHzP/Dkxuq8ipH9IQQQ8dkmXjBUc92iKH4J5UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rthjuziN; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rthjuziN"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3a49623b865so3740406a91.0
        for <linux-security-module@vger.kernel.org>; Thu, 08 Oct 2026 22:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791522671; x=1792127471; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lE3/kQE3CWaeZ8e1J8lpY+d3lLDFtCRTYFUR1YExG5s=;
        b=rthjuziNL9aQraViHXIBDfRDuuhmkSGKHCDOWWqBy3zIDTVNFKO0DX5orM7oystYm4
         oTdAmuiZtZG6QTOt+9UVMx5lwI/dM9qMF8l+HBCP0n7WGrXr76wlGPiOM4V1RUsVoNyD
         GPKnlgqool1h9J3015snqngIBzK0nXoVeNoNP8+cruMee54v//GqUcDdatv/GZquTFNM
         C1M0+xn8yr6xihflBlhbszh/4nyWgScvOd1wXSnNXjs9iI0tcwTcI+2mo7SLt4Zt2QjZ
         oM8QBoPItFuQNocyM+VFZPhNXn4vnB1/0zMKvB/ArmO9TO4H7PATCZFAdJ+I65lPoBJI
         ciCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791522671; x=1792127471;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lE3/kQE3CWaeZ8e1J8lpY+d3lLDFtCRTYFUR1YExG5s=;
        b=JOPdmRrhjwwFfq8BQTpmhHh1qO04gpmRpmLuv5o6zjFupbyPLuY63Q1VplmnjibgHR
         yHYOVSlf6xB7Mj7qAB3VgI86AQDejyUUwMk/CWUsaqvPh6hWGO8jvQwXdQa7d+K4xFKc
         BSG8zDucx2uUFYXzib0rI+mdtLQaH6OzqHNr7Rsqku7ocjJX2U6DI7WPYaUQ7xgIDNMk
         K6RtY7PX8FyndxDytqxoxU5EVbg8WYwa3jSLJiAi94C4I4rCLueVzRXRtI0CaDHk4TFy
         eshB+6N3Fg616/mfcwrQ8ZLrZC6/btPRFN8r59vwJIBhSVXy25UEcAV+3rVEnGB9UlVF
         wXZA==
X-Forwarded-Encrypted: i=1; AKwUvBy12gGELEu1RLktYNRXGCUrGe0+5fxp+zcnIo2kE45fPTqRGz6UBPzuld+bHhNsf7wAWiLTCnSP7YHS7pminMQIMDLVR2E=@vger.kernel.org
X-Gm-Message-State: AFq9FYI4PE1AsTtpk89vXfieW12bBNC9tfMMs3OfueCWQIEfqtZ2rkit
	bSEUOXp+UsgegRFo0Mt4IKPNlja9NSCexoRrSwnNdbSGBAksHsTmkr9g
X-Gm-Gg: AYBFou0HpDQtB/UXJ+CAfQ6Plcd5VoU5awvGd51wumT5gc3gcHW6E1PsuvtpD1Jvvqn
	E9o8ppSWOI5ifpWCY1IyeUXVlhUd3EIFv3ph9AKno2apsb4J8ieATrtfcypBE5MWEmh3vH7rGHJ
	YhD/k4hc0alREhwtbWtIARCSll5X3gYZITLmAJdg39n8k29qO+ZjYmUybSiObzffSvDxCFR8X+7
	ELlEMhDMbklyNJB9Q+oB0bmK5trST5QtOr58h991WOppXl9lZ9ucOZskGQfR8pQxIaKHS+YIGkh
	KWbPJkW2le9YHrAIV2iVjjb/+amiGOJBubl0mBe0LWVsdrzlcTAWQ1om3WyiHxa9aQ0jgNkw/88
	6Eo9YB5VzzEyhQ1fP6lDzph4nyH82T9QzIHjrbB7VbWMVvgvMR0yLpcnDE33Zdc/XPxrLPYP/jn
	GwIYBFeMil/CFqPRkVLs+pdd+8Mdv+HR+Fu+UM2qzEzqt1fTtGQQZVZyGR5oTQp5Qmhw==
X-Received: by 2002:a17:90b:1e41:b0:3ab:de4:7fa5 with SMTP id 98e67ed59e1d1-3ab3a9726admr840824a91.56.1791522671042;
        Thu, 08 Oct 2026 22:11:11 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab36f73e7fsm1925492a91.0.2026.10.08.22.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 22:11:10 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: dhowells@redhat.com,
	jarkko@kernel.org,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com
Cc: keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	jjzuming@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH v2] keys: Protect the type name while describing a key
Date: Fri,  9 Oct 2026 13:11:03 +0800
Message-Id: <pm-key-management-objects-candidate-0009-v4-6b537c5732fd957c33fa@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

keyctl_describe_key() must keep the key type's name alive until
kasprintf() has consumed it. The retained key reference keeps the key
and its description alive, but does not pin the module providing its
type. The name is passed to kasprintf() without holding key->sem.

kvasprintf() uses the saved name pointer in two formatting passes, with
a GFP_KERNEL allocation between them. With AF_RXRPC=m, a task that
passes View permission before type retirement can overlap a privileged
module unload in this order:

1. KEYCTL_DESCRIBE looks up the key, saves key->type->name in the
   kasprintf() arguments and completes the first formatting pass.
2. While the formatter is delayed before its second pass,
   af_rxrpc_exit() calls unregister_key_type(), which removes the type
   from the registry and waits for key_gc_keytype().
3. The collector takes key->sem for writing, retypes the retained key
   to key_type_dead and completes retirement. Unregistration and module
   exit return, allowing free_module() to release the type and name.
4. The formatter resumes its second pass and reads the saved name from
   released module storage, which can fault in string().

Hold key->sem for reading across kasprintf(). The collector then cannot
retype the key or complete retirement until both formatting passes have
finished. If retirement wins the lock first, formatting uses the core
key_type_dead name instead. Release the semaphore immediately after
kasprintf(), including on allocation failure, before copying to
userspace.

Oops report as below:

    BUG: unable to handle page fault for address: fffffbfff8054794
    #PF: supervisor read access in kernel mode
    #PF: error_code(0x0000) - not-present page
    RIP: 0010:string+0x23f/0x470
    Call Trace:
     vsnprintf+0x330/0x1110

Fixes: aa9d4437893f ("KEYS: Fix the size of the key description passed to/from userspace")
Assisted-by: LLM
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
---
Changes in v2:
- Trim the Oops report to the fault location and vsnprintf frame.

Link to v1: https://lore.kernel.org/r/pm-key-management-objects-candidate-0009-v3-43bbf21d1c452f23d829@gmail.com

diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
index d14ace88e529cb77de5386f1f3a99905d4b7688c..5a5efa26ed0ece3a5ab22e37ad7bda7a5a744b83 100644
--- a/security/keys/keyctl.c
+++ b/security/keys/keyctl.c
@@ -677,12 +677,14 @@ long keyctl_describe_key(key_serial_t keyid,
 
 	/* calculate how much information we're going to return */
 	ret = -ENOMEM;
+	down_read(&key->sem);
 	infobuf = kasprintf(GFP_KERNEL,
 			    "%s;%d;%d;%08x;",
 			    key->type->name,
 			    from_kuid_munged(current_user_ns(), key->uid),
 			    from_kgid_munged(current_user_ns(), key->gid),
 			    key->perm);
+	up_read(&key->sem);
 	if (!infobuf)
 		goto error2;
 	infolen = strlen(infobuf);
