Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2C31B4236
	for <linux-security-module@vger.kernel.org>; Tue, 30 Sep 2025 12:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759234368; cv=none; b=rjsEqT8zk05RQMiSyFZW/u2bQmlNXkMgD4vm8W/Q3E0YgLGBdw0pnvVbhKwR0VyTlWV/9+e0Ix5PH4E6DmGh0nF16LSOS9n7At7ULgAojhLAGFon/sd8W7y9MiicL/txLMNa7pfr1jAXx+mrIqrTVsQsXgVpMNrrK1nN0fvuXr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759234368; c=relaxed/simple;
	bh=8hAe6inhz0E/QWnBDuNMlbdqmEfM/Hzecqaiue2MllA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=XVrfT95I/qQHYcYP1WbRn+s4PgcFV88Dvs/TzqpLcIqXQU5QEq27HHPxX+CIOc5rxc5MTHSQvRBRXS+RddPIgEU0idt80Lf+fbKw7ygh28sLBXW+5UKILUiri9BCO4j8lZgbdxPfyZrp0BnQnnI4AVZ/old1A5Ql/FI7dVX2KFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A8uMshXc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A8uMshXc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759234365;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CWIgSoKL3urKBOhTmtSOXc8Pl4O+FoLwxpjwzaySij8=;
	b=A8uMshXcz+1FzFgrw+Y+2MiugZhHxwlMOt0KdUlpA9fT1Hje/CmdcqRGS5OYrQb+E7Wc7a
	T/70IS/9RVEad53cwj2EUZ2b37itzts4eK3sKVYENaglaMXgSWZo4RuyT3TkHAQZvy1Yaw
	NrvFg5BGdFQYmOQQlBST9uFZEfcttjc=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-QvQQ_9hYMnCVfIA7iOCkew-1; Tue, 30 Sep 2025 08:12:44 -0400
X-MC-Unique: QvQQ_9hYMnCVfIA7iOCkew-1
X-Mimecast-MFC-AGG-ID: QvQQ_9hYMnCVfIA7iOCkew_1759234364
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b2f9dc3264bso783879866b.1
        for <linux-security-module@vger.kernel.org>; Tue, 30 Sep 2025 05:12:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759234363; x=1759839163;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CWIgSoKL3urKBOhTmtSOXc8Pl4O+FoLwxpjwzaySij8=;
        b=K5Gbm13li0KWOimyaxZfGLfq2HPrnhgYdrrDyb3IX9gHMr5pvzy85c4NYhPwM2e9h4
         m8bU1PnXkCXOvKYoCVdDe+hE6opqc3bkN2BX6dwjVNsI179WDaUaANXAaS988Sp4UTo5
         7Da7S45bl4O9kqKlxs3a1HKsW/zg8B9nxXS6rKf8+TzGNK+P+z+uARYeCgRfGCUuFfOH
         g6mIBfcfZxBbzSviGTpDxYYucoTdpggL5kPk/4ydVbyGV2GiG+/EPdbPzRs34SiZ1swo
         jcRhWQ1UdmufwsVsteEktGObU3PibT44hGoI2/I5S1Ar9IYcdXYc45/z6a+D03G8LjX/
         6uJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVF6l/l1GFDsRiwLKkdEvq5mV8cw9bTBh8q84miJy33gDWQ+rMQGrM5aIOfQVU7Dbj8NPTNIjdXmBWNptgJMG3RLn3JdEw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzR4eY8MgLe6eRhTroq5F4l4t3J1tEe8xxQDnnDFyWKb9L5Ks1B
	agXPJT2qCRnml1xlg1Eyj77uRzd2kJNc++XD/PJ4kM0q0mSKYNYCe5/Y6snel4iZOVOsD++MPek
	l99nmjNfwotxbHZEBU6fkszkg93iv9Bcsn6siTcocthZ1uMCpr4aFUQryz6oVFURk7QflDShQeg
	zDrw==
X-Gm-Gg: ASbGncuU9rfzrJX66pM7BJpGsIp6s3yEo/JiLW/cl3r91fQGw3l+qeTSpvp6SgIdUEL
	NuQQijZLdm8xtrSyfRza5IzYJ/DlUc91z5tSiQ1x4RujvHhiXaFd/12FO3wmpyR/LU/rCx9CKVM
	eGQsBqTCFT0kzit3tVN73izlLiQHWynGmq1ZcgfgjzaJBx+ceF7MOXnMAxHQJFfpIA8W4kG6NIM
	f2XxpCtoTdZ3SmzxJK8V0F4Bbjwfox5tZLCH59CxVbEjWk8na0Fa04Jz43nGNvAzI+5BDGSuBHM
	KK1qCPSyfx1/BiIq0tqKFiBfltx26/jSrMnJyvlnJ2aXMN4oQmLs9MT4EIfCsza9BY+XzKjzXMb
	v0xIv9eVPa8XYpKCA+n9s6A==
X-Received: by 2002:a17:907:3c8f:b0:b04:36bb:545 with SMTP id a640c23a62f3a-b34bb12fc3dmr2371563366b.48.1759234363478;
        Tue, 30 Sep 2025 05:12:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCMW+GDcVwUnAC/efDdJR1OCcQoMagIWww3faxZxGxD2S8ezNsWbFnZUmUdO9qvxkKur0+NA==
X-Received: by 2002:a17:907:3c8f:b0:b04:36bb:545 with SMTP id a640c23a62f3a-b34bb12fc3dmr2371558866b.48.1759234363046;
        Tue, 30 Sep 2025 05:12:43 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-153.retail.telecomitalia.it. [79.46.200.153])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-634a3b05779sm9854125a12.49.2025.09.30.05.12.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 05:12:42 -0700 (PDT)
Date: Tue, 30 Sep 2025 14:12:35 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-integrity@vger.kernel.org, dpsmith@apertussolutions.com, 
	ross.philipson@oracle.com, Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>, 
	David Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	"open list:KEYS/KEYRINGS" <keyrings@vger.kernel.org>, 
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 03/10] KEYS: trusted: Use tpm_ret_to_err() in
 trusted_tpm2
Message-ID: <7icpto3rnm2f4u6zaxl4xy7zvar3q4hhpgelq2gnazszdkwc3m@5dtivkqs5xdg>
References: <20250929194832.2913286-1-jarkko@kernel.org>
 <20250929194832.2913286-4-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250929194832.2913286-4-jarkko@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: dJBNzub9v7SGHUdyeibC0w5M2GclVxW4jnIgAQ0SlyQ_1759234364
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Mon, Sep 29, 2025 at 10:48:25PM +0300, Jarkko Sakkinen wrote:
>From: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
>
>Use tpm_ret_to_err() to transmute TPM return codes in trusted_tpm2.
>
>Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
>---
>v3:
>- No changes.
>v2:
>- New patch split out from the fix.
>---
> security/keys/trusted-keys/trusted_tpm2.c | 26 ++++++-----------------
> 1 file changed, 7 insertions(+), 19 deletions(-)

Nice clean up!

Acked-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
>index 024be262702f..e165b117bbca 100644
>--- a/security/keys/trusted-keys/trusted_tpm2.c
>+++ b/security/keys/trusted-keys/trusted_tpm2.c
>@@ -348,25 +348,19 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
> 	}
>
> 	blob_len = tpm2_key_encode(payload, options, &buf.data[offset], blob_len);
>+	if (blob_len < 0)
>+		rc = blob_len;
>
> out:
> 	tpm_buf_destroy(&sized);
> 	tpm_buf_destroy(&buf);
>
>-	if (rc > 0) {
>-		if (tpm2_rc_value(rc) == TPM2_RC_HASH)
>-			rc = -EINVAL;
>-		else
>-			rc = -EPERM;
>-	}
>-	if (blob_len < 0)
>-		rc = blob_len;
>-	else
>+	if (!rc)
> 		payload->blob_len = blob_len;
>
> out_put:
> 	tpm_put_ops(chip);
>-	return rc;
>+	return tpm_ret_to_err(rc);
> }
>
> /**
>@@ -468,10 +462,7 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
> 		kfree(blob);
> 	tpm_buf_destroy(&buf);
>
>-	if (rc > 0)
>-		rc = -EPERM;
>-
>-	return rc;
>+	return tpm_ret_to_err(rc);
> }
>
> /**
>@@ -534,8 +525,6 @@ static int tpm2_unseal_cmd(struct tpm_chip *chip,
> 	tpm_buf_fill_hmac_session(chip, &buf);
> 	rc = tpm_transmit_cmd(chip, &buf, 6, "unsealing");
> 	rc = tpm_buf_check_hmac_response(chip, &buf, rc);
>-	if (rc > 0)
>-		rc = -EPERM;
>
> 	if (!rc) {
> 		data_len = be16_to_cpup(
>@@ -568,7 +557,7 @@ static int tpm2_unseal_cmd(struct tpm_chip *chip,
>
> out:
> 	tpm_buf_destroy(&buf);
>-	return rc;
>+	return tpm_ret_to_err(rc);
> }
>
> /**
>@@ -600,6 +589,5 @@ int tpm2_unseal_trusted(struct tpm_chip *chip,
>
> out:
> 	tpm_put_ops(chip);
>-
>-	return rc;
>+	return tpm_ret_to_err(rc);
> }
>-- 
>2.39.5
>
>

