Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7634427381E
	for <linux-security-module@vger.kernel.org>; Mon, 22 Sep 2025 09:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758533163; cv=none; b=B3NF6ROkiTLa8fh/r06ICzs6goofe5hEMRfYrfKIfUHCKD2H9uj2jTkOi3SGiGAURWjtWV8KPoL1RuWIhScYOXoNpL4J9oaysvoQ02bUliSDAYnS3VwwDCNVTQ9QJlhmx58Rjwr8xTJ+zTwvWPsIyxxTfGhKQcOczTK9fVSkH9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758533163; c=relaxed/simple;
	bh=nyjXxEfScQl0f+qKx/QuarmizK/Rrjns65gQi1ZZxv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=fMTrHv4KddJMrF933rH87sBYL/cdWhq8jWgGd/ZyYFWnJ5zC7oaOs8AHYcRnnu9GsPG1frSQqfAofy/re6oP7XOHgY8r3jX/4RKWLnuDt2kkBBpzUNnvoRmEY54IN8pidqm8vpohPkrQ6sjQoirtnf4T6OVlhk4/w7zmIIcO168=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e8fNtN5e; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e8fNtN5e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758533160;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9cF8ChkrVjedqQcH45KxT9cWQe9wu1GihjCbg8HEDV4=;
	b=e8fNtN5emDdcZIHOcHHkqA8ewmLEZ5htGW0SRzhllMBJCeLVkUq/ubTv2fId75tTzE+n43
	63IYYLobwfGAJkdcQSBAm/3I03x9XShFKtFDcts6+rsXII00+6tMaKiZkyVrOT2tLfCczD
	Rp+d3B/O/tUh25vqk1yLCf0dbS2zcIg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-503-EZUTFFigOBC_SvDRB1dskw-1; Mon, 22 Sep 2025 05:25:58 -0400
X-MC-Unique: EZUTFFigOBC_SvDRB1dskw-1
X-Mimecast-MFC-AGG-ID: EZUTFFigOBC_SvDRB1dskw_1758533157
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3ed9557f976so3854605f8f.3
        for <linux-security-module@vger.kernel.org>; Mon, 22 Sep 2025 02:25:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758533157; x=1759137957;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9cF8ChkrVjedqQcH45KxT9cWQe9wu1GihjCbg8HEDV4=;
        b=lz8lkjQYFZpCY+dpGTTOvcb/DhaA3QlNipre2VIXSGrWaArmXdD1qXC/PMsSle04jF
         E7x1/SO9CeHm6I0vBMcfbPOuyFsJaSGbbeTzU4qu4BFGFzljhz3MGB2LYFUnvTdNOYzy
         V5b6FL+Sk6twYyTIjv5H/9LZE88UTMt/XBMhpoelYMa2k6PUt/WseQ658uaylsVeBT7p
         xk7BWqSE4s+Ym07dq153qrUu68Q31OIiiPPQOiNhz+NKtt83mNyerHbGcIijbLBu216H
         XOrlAlPKvPjGXCv7Ri6WTgqhL5XsvigKjU+qtuyBDyhoXSivL3WKgAbaYAtJ5oOIO0ZG
         7+dg==
X-Forwarded-Encrypted: i=1; AJvYcCWcTgCo5CFWMjF3+7g+jVXYTeT1X+5lTrk0Vm4fTVEV82qurrCI6nACghLO0FjDhZJj7wllWifHbZ/YoXfaiDNQpj5k5wc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ7ITDLJ2mkTLuJIECVII+Z2U0rfzi9rNY1QjTBiadp94xQKL5
	e9scTfw/5kMz8zrcu2Ktf3a0ConDlRldPEmD52vtryCkO2oXDG36/4PkhRCSgfo6XzdzSkFCvOn
	dK8XJxNxaEVgF4ad/LnI/idrGTYBABM7WpXjZB/MFdZEs2hH+ZVMOK/aIxIboyWEIXXbEWiF/x5
	AaoQ==
X-Gm-Gg: ASbGncsM/jBMkL8yNMQ8GecADJZvUY4EzzanCZtb2P+bhAAo2C2ELPatdeAzWU10YIS
	V7+YdqlkCNhbJDIkF3PbLVPZsOeTfNowKQsbaR5t//O8ldzN505bi6cxhhpXfWD4MSEA+8zYIAN
	Gz5qxMDp9XPhRpvocJWEjfov3BWfPIfxv38v74VsipU6lK5umzKWqRPjC25iFUMRiCKQ33TPSXp
	d3epcX0Nw3AULBzG4SFOiudW8ynrU0PXE2gkbfzJw4vXtWLhmjHeqejgEXmGWAWwn/OYayRywUQ
	3lUAwKZTBPs8dn3RI0OrowGGQVuzv6eEoA98Nt4tvg==
X-Received: by 2002:a05:6000:184f:b0:3f9:bc33:2fab with SMTP id ffacd0b85a97d-3f9bc333465mr4024930f8f.60.1758533157358;
        Mon, 22 Sep 2025 02:25:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7fSov+1CGFL3df2Ud9PtHq3VhZvRxdYHyIR+xrzsZf0CNdXIba9+m6tklp40NhmnBLxQYvQ==
X-Received: by 2002:a05:6000:184f:b0:3f9:bc33:2fab with SMTP id ffacd0b85a97d-3f9bc333465mr4024904f8f.60.1758533156898;
        Mon, 22 Sep 2025 02:25:56 -0700 (PDT)
Received: from sgarzare-redhat ([5.77.126.50])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3fee58e6e25sm3153566f8f.58.2025.09.22.02.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 02:25:56 -0700 (PDT)
Date: Mon, 22 Sep 2025 11:25:42 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-integrity@vger.kernel.org, 
	Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>, stable@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>, 
	Jason Gunthorpe <jgg@ziepe.ca>, David Howells <dhowells@redhat.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, James Bottomley <James.Bottomley@hansenpartnership.com>, 
	Mimi Zohar <zohar@linux.ibm.com>, open list <linux-kernel@vger.kernel.org>, 
	"open list:KEYS/KEYRINGS" <keyrings@vger.kernel.org>, 
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH] tpm: Use -EPERM as fallback error code in tpm_ret_to_err
Message-ID: <tnxfamnvxoanaihka3em7ktmzkervoea43zn2l3mqxvnuivb6n@p5nn34vns3zf>
References: <20250922072332.2649135-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250922072332.2649135-1-jarkko@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xnwbiR1bPXXUKpJoiNa1RFtDNA_u2zZDXtb2l3TrBnU_1758533157
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Mon, Sep 22, 2025 at 10:23:32AM +0300, Jarkko Sakkinen wrote:
>From: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
>
>Using -EFAULT here was not the best idea for tpm_ret_to_err as the fallback
>error code as it is no concise with trusted keys.
>
>Change the fallback as -EPERM, process TPM_RC_HASH also in tpm_ret_to_err,
>and by these changes make the helper applicable for trusted keys.
>
>Cc: stable@vger.kernel.org # v6.15+
>Fixes: 539fbab37881 ("tpm: Mask TPM RC in tpm2_start_auth_session()")
>Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
>---
> include/linux/tpm.h                       |  9 +++++---
> security/keys/trusted-keys/trusted_tpm2.c | 26 ++++++-----------------
> 2 files changed, 13 insertions(+), 22 deletions(-)
>
>diff --git a/include/linux/tpm.h b/include/linux/tpm.h
>index dc0338a783f3..667d290789ca 100644
>--- a/include/linux/tpm.h
>+++ b/include/linux/tpm.h
>@@ -449,13 +449,16 @@ static inline ssize_t tpm_ret_to_err(ssize_t ret)
> 	if (ret < 0)
> 		return ret;
>
>-	switch (tpm2_rc_value(ret)) {
>-	case TPM2_RC_SUCCESS:

I slightly prefer the `case TPM2_RC_SUCCESS` but I don't have a strong 
opinion.

>+	if (!ret)
> 		return 0;

If we want to remove the `case TPM2_RC_SUCCESS`, can we just merge this 
condition with the if on top, I mean:

	if (ret <= 0)
		return ret;

>+
>+	switch (tpm2_rc_value(ret)) {
> 	case TPM2_RC_SESSION_MEMORY:
> 		return -ENOMEM;
>+	case TPM2_RC_HASH:
>+		return -EINVAL;
> 	default:
>-		return -EFAULT;
>+		return -EPERM;
> 	}
> }
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

nit: since `blob_len` is not accessed anymore in the error path, can we 
avoid to set it to 0 when declaring it?

Thanks,
Stefano

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

