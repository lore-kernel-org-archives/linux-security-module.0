Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F12330F552
	for <linux-security-module@vger.kernel.org>; Tue, 14 Oct 2025 23:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760483587; cv=none; b=CcwjMfNg55Cs1UcCVo84eFQvZW41ytrqw+8VuwP4NZNwp280a7wU2cteJJDi0Ci5Ye7V4Ta9c1NX0riK+L+z+5jX7y/S7TxoLDcBRVIN/ZlMJnWbxlg8Xs7Hb9cGjI/CfMGIBJqC24L2SIhlmnADvzTb/edvDerzxU1luPFuZRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760483587; c=relaxed/simple;
	bh=QprGc4fiwHa2sVunw/L0P7g7jj+8/eCfXo++KOzEjFw=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=ntv9BCiiDsqIABIBDJd0OCTcL+YR3HDNiNXVMf4NsuWyEfo8fZTjkv2HbIrMXPyfLprIqrLr4aMIMjtk9MYJQyQhTYj3kqdiSqz11DhSR+IeUjwgIEDjIbCMUog4YWsbfMtCiLcHiuzpsiEuJwHj/rNYMxKqAGXZWmKXQnisPts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=VObL33kd; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="VObL33kd"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-78f75b0a058so76305566d6.0
        for <linux-security-module@vger.kernel.org>; Tue, 14 Oct 2025 16:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1760483583; x=1761088383; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yCW09LQMgNqzUYKFVauSk4HK5abMbyRb6NkfqMu8LB4=;
        b=VObL33kdBRcegxC5zg5IwEsSUT3HP2fPT2B5SZANu6tODJvYc+EBeHHUm7U95ZC6g1
         OII0LORH3orDJnFNE3wVOpgtOKUtY6ubMu9sCmaeLv1mWUDZeCmieQ11x2MEjRmALOeO
         08ADMMxBOtlahaB7uP8080ni4Pki6+Afutmvf2uBWIT+GTYTf5p7MN+60cOKR9+ajeBQ
         vGOO3g6cOPws8EKtMj7aHzcoexLT3f1NTQzOtv1kP/jlwkZgxpINjsewOuABeE5TV1pD
         dL44d3Udc7MKFImerbo2XdhwfEEEqGUJdPolOHKRj+kod8vQZESkBJOJZe595pJpOTp4
         h8uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760483583; x=1761088383;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yCW09LQMgNqzUYKFVauSk4HK5abMbyRb6NkfqMu8LB4=;
        b=IAhhlPvABU8+Ilh6G+Nl/lj3s685bYF2tTLoEgalsgR/6bMXyI4oIC+etYnH1DL80B
         s9j7/Rd5nsOu+ufMKB6O08nwZ31wcGHQVsSGvhuhM8LP2Hi/WDtDCm9B3j4x4eom67a2
         2AvKJJOf4rIlw0w7oOCKVQi9HRtkrVArLhJG1vMc4zIpdEuZs0l70K28Pwn3lCiSldqY
         sd90o1YbXbwH+j8V6a5ON/PaPVfhajs9fi4ybEl6sDntHsPFFyraqCAYCc/XUkgmtfIw
         MD7is+wWkWT+R9tDUkYb6q31P4OSL+HNF47eLccYxW4GrQILts0PPfCG2C8uAGKd9nMI
         DiNw==
X-Forwarded-Encrypted: i=1; AJvYcCVBLHbCqLP0zD5NwF/Z/btvL97yC7LGWqcPal3PiHZjWSiW4ey7CayrbfpOHOHWMFZENKkCLebHRSjEwiez8mpzuEgxn8U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQSyBCkxHWdn8TpSB02p1FeljqIlozRALJOct7kvLvS2L52l8C
	Mn4N8vbRWM9zSu1u6WO/rlM5wKDZATTAMz9J4eZWJD4VFzCnr5G/ypaSC5AqDmJyKQ==
X-Gm-Gg: ASbGnct1pViq3QQ9kMQPaF+uqJlJiAdhmmqkSbMCuSqJl9oxBKx/lszZsOPiddv/3jk
	H/cDFeTjJUhvD9MAAc8x4qXG/PQkSoQ21kncV/mRBjB+s7K/9gG2KODEOFTrL33Up6hdxLHzIzN
	yPxmQzDTSZQn4UBDKGBMeFJxwZMxo3Jx5pTkBpCzNrdAMHUV/iFnu+hvdbRdWq/Nv7JSFVQwKzI
	fn4eQAybp14YqDBY101w+fG5U/Sm0/DEKouYG4apT5mTdKIWVfYMhOGjyh5wa3ol9fe7FX0TPm5
	udArqcO7I5sN30EFZby1ffj6uWjIHQYFYtZ4ZWmYDR1s1q2iF8yxG2gax9KA4LbPc70UXECivLX
	mU+gHOOjX/nX3eU+RNx5RF6aYHpmKVtq3MJgAUVraJGwZw/RWt/MTtiR8w7uhRqm4nvXP+HWSie
	XOZn3lfyMfOTI=
X-Google-Smtp-Source: AGHT+IF0vEhjdhHpWJF1o9JDZ1M/kFsunpPIr6Pvii9L9sJVyjdFhsPC87oa0AUhanzmNTmFesh0MQ==
X-Received: by 2002:ac8:5902:0:b0:4b7:aa00:1e6d with SMTP id d75a77b69052e-4e6ead74a71mr387673051cf.76.1760483583382;
        Tue, 14 Oct 2025 16:13:03 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-87c012a1cb1sm6847536d6.45.2025.10.14.16.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 16:13:01 -0700 (PDT)
Date: Tue, 14 Oct 2025 19:13:01 -0400
Message-ID: <9ebb0de0d0a7b889b70e083a99c59d13@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20251014_1821/pstg-lib:20251014_1132/pstg-pwork:20251014_1821
From: Paul Moore <paul@paul-moore.com>
To: Casey Schaufler <casey@schaufler-ca.com>, casey@schaufler-ca.com, eparis@redhat.com, linux-security-module@vger.kernel.org, audit@vger.kernel.org
Cc: jmorris@namei.org, serge@hallyn.com, keescook@chromium.org, john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH RFC 13/15] LSM: restrict security_cred_getsecid() to a  single LSM
References: <20250621171851.5869-14-casey@schaufler-ca.com>
In-Reply-To: <20250621171851.5869-14-casey@schaufler-ca.com>

On Jun 21, 2025 Casey Schaufler <casey@schaufler-ca.com> wrote:
> 
> The LSM hook security_cred_getsecid() provides a single secid
> that is only used by the binder driver. Provide the first value
> available, and abandon any other hooks.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  security/security.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/security/security.c b/security/security.c
> index dd167a872248..409b1cb10d35 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -2740,8 +2740,13 @@ void security_transfer_creds(struct cred *new, const struct cred *old)
>   */
>  void security_cred_getsecid(const struct cred *c, u32 *secid)
>  {
> +	struct lsm_static_call *scall;
> +
>  	*secid = 0;
> -	call_void_hook(cred_getsecid, c, secid);
> +	lsm_for_each_hook(scall, cred_getsecid) {
> +		scall->hl->hook.cred_getsecid(c, secid);
> +		break;
> +	}
>  }
>  EXPORT_SYMBOL(security_cred_getsecid);

Another case of "would this be painful to do at registration time?"

--
paul-moore.com
