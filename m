Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C8C1DBB36
	for <linux-security-module@vger.kernel.org>; Thu, 31 Oct 2024 22:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730415231; cv=none; b=QrcObH8eHkbUEV+f2B3NwhXd9uT048SM3oqtaWA5fvARs5D/+wO32ObiftAEmqvj7qRhyIeHtw6ra2oXKrjGfQokF88ebIHlVflJl1feQ+DsWYcSLgjs5GyMO6CyO4ZQDAdN86QR/QdfxL0hjtEj7j6Pxg9vdJtA0lZrfomHPLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730415231; c=relaxed/simple;
	bh=lZVUy6CT2xfH+CAuoNtGeBUN2aklgjohf5KFRghgbZI=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=kbzwozD8qHMCHKwxYWovqEptsVyb9kOWGbvSbnlewhhzjtFzHafR4w5WnZaiWDymknwks3qjPjJkBQBOdUHQQ5hT3tU8gyVIhNRHEc5c+YCVlwqLmZn4YznNiPOd5pnUDOILapUZncSaa6V/qrFbZuboqXw9qKIWpKhW/w9XNQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=QA7Izg30; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="QA7Izg30"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7b1507c42faso195950285a.0
        for <linux-security-module@vger.kernel.org>; Thu, 31 Oct 2024 15:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1730415223; x=1731020023; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OryhN0ZlONGvRFH33cTUoM2Hme/OP4dCS9YbGTHGdck=;
        b=QA7Izg30oc1vSG7IsFKrq9RLxYzvsbftt3+mwW8M/gLWL6yymnkgjat/jgaP5Gnvzf
         04qUb508rVrhEZ5odZJruRTOlAW1ZltWqPQcce733v2cWQhmnB5wmGUvrC70VOIdzG/v
         vWz3RdIwcaFbOr9i0MU11S5+S9uokYe4aL6xyg5oiMjpy1rnjBUM/oUxZEr+cekeJTdA
         Cx5ipMpOpZ3wCVh927SZ4y9hkQTEfEsinUchc4/Xfvv1k3YgXSbgE2IEj/7N0Las8LmN
         3rz/5b6FHzv7zsGXZmy38fwSGwRt0P6Tpnx0nm2fJTBdZT4xwiJnvqdHWXeaUyZoqeMP
         9bZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730415223; x=1731020023;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OryhN0ZlONGvRFH33cTUoM2Hme/OP4dCS9YbGTHGdck=;
        b=YMuuNUN+5PfLqVyHf1pu9/9qBh2qDzMNf8umi36+UMLBpd3uEfmHHQJjBudImpsf1f
         0NSqqaBwdHNDPD7QvJ3TurnpN3s3RP6fMXMMK9h96jEdcZVjiJ9iaJvP80Tg8JH0EV8D
         0idjV+JY/+iSeCoot+JtdJTE0vFRHVu+d7bLj4ojZA7QScr5bF5YUZB0XLBbbP4r0lGA
         h5gVc7OdMOo95HF9MTV4GIV4/iBLnSsLzAIZlvid0V+yuScvRRBgXazuCYt4LBKenKwn
         Te2OXBw2bFdVIUU7rHeAqO/+Fy1SF0jg5kAy5ZfMMzUtatC5L5CTmjkubeURC8jHN/1y
         Jwxw==
X-Forwarded-Encrypted: i=1; AJvYcCX2oX4LH8g76D2xuhxhtsGzyEsXa/i98VseMM6Vh+SAWii3e0T2m/bR8hhMOAmhAZGAR5oXJ6GvGsSroSgy18N1eUpRYjo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpAf3B34pg5aa77h69Sq1jqc/LV9kDgJpg64cqs6JdshKaji3m
	nS1y69/x6TZLdHtZNHtDjVsI3/Mb76HuiIFxUezcVxuDq/X9kqmsXk4OgCn26g==
X-Google-Smtp-Source: AGHT+IGk3MtE2UlABsbiTHjlYLvi4TvMpopHs6UsBnSfvXRUKlH33/ovhbphFSBsW/Hi7+aTcXuQLg==
X-Received: by 2002:a05:620a:40d3:b0:7b1:8cfa:9222 with SMTP id af79cd13be357-7b2f3cd6603mr653801485a.1.1730415222731;
        Thu, 31 Oct 2024 15:53:42 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b2f3a9babfsm114210485a.125.2024.10.31.15.53.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 15:53:42 -0700 (PDT)
Date: Thu, 31 Oct 2024 18:53:41 -0400
Message-ID: <424b4bb4db5c4e126072179ac8ac8fd2@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20241031_1534/pstg-lib:20241031_1459/pstg-pwork:20241031_1534
From: Paul Moore <paul@paul-moore.com>
To: Casey Schaufler <casey@schaufler-ca.com>, casey@schaufler-ca.com, linux-security-module@vger.kernel.org
Cc: jmorris@namei.org, serge@hallyn.com, keescook@chromium.org, john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org, selinux@vger.kernel.org, mic@digikod.net
Subject: Re: [PATCH v3 5/5] LSM: secctx provider check on release
References: <20241023212158.18718-6-casey@schaufler-ca.com>
In-Reply-To: <20241023212158.18718-6-casey@schaufler-ca.com>

On Oct 23, 2024 Casey Schaufler <casey@schaufler-ca.com> wrote:
> 
> Verify that the LSM releasing the secctx is the LSM that
> allocated it. This was not necessary when only one LSM could
> create a secctx, but once there can be more than one it is.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  security/apparmor/secid.c | 13 +++++--------
>  security/selinux/hooks.c  | 13 +++++--------
>  2 files changed, 10 insertions(+), 16 deletions(-)

See my note on patch 1/5, merging into lsm/dev.

--
paul-moore.com
