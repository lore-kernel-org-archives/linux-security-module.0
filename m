Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5211A3149
	for <linux-security-module@vger.kernel.org>; Fri,  7 Feb 2025 21:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738964582; cv=none; b=AFONPBXdmIeABTuwl79xJTGNQHIFkKo0TA/YVScghv9MabHNVrCvDvTvJ2jjqW1OEG1ljk8lPRhK0rkwwub4Li43pEjSTBGOk6W7jZOpyfrtBzBvOEDRYzSYlnGLXO0biOEgjsJZrLnUXmP4Va0CexY5uvLjTV316w2wq09OK5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738964582; c=relaxed/simple;
	bh=YY45Gnycd+3o7hKOW8C8JWYriuERUUgTq475FPmCvGI=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=RuAYkPdp/lDj9zrs4W3Mp+5tCe9BmjTuSQuYk9Zku6UTrAgVLf4W6xG4mWWlDbNzY5Dj2fX5alFXZvu7CWc2HsIiFL/gao7/GHeiKrgr85KqFZnutSGRs8uxp7wCKHYnMEcUJgKcirvF+uFwSUQDe2zBNx+24k9XH88Ky9AaF1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=U3lj2Y/H; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="U3lj2Y/H"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6e43a5f59b7so24419636d6.0
        for <linux-security-module@vger.kernel.org>; Fri, 07 Feb 2025 13:42:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1738964578; x=1739569378; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IvI4JoqoZo9YGBOkVNl+HIo1GyCi9K0UiyKNezQvlcg=;
        b=U3lj2Y/Hx5rw231y8IvfEZA+lYWKI2a/kzxlcQ8vJa/yp7+fGbyE40xukdNfaPhLBS
         eyeDnWgB5AA8dq9i/vKzwxnC9ODoz6u7VLzacFdmcaG5qP9mSgTEd/+akTpspOncMGuB
         eGO4GX9HdY7HcVy7hLgPRbXbexsqMMXVGXE3kNBNBI2wkNY6ApWORKUc1VjMhyX9ewfa
         AjWGpToEHycw8wORMj1lwuSUk17dnep90bRZD8M+Nhobnvrzm0sp4yMdyN3TuAYupkbU
         imjbUreNvBUyeHuWItTJeMTj8mBBy+8jETR8lPzeBfbDVpJ9TttR5w/t47qQFv6iVTj3
         A9mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738964578; x=1739569378;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IvI4JoqoZo9YGBOkVNl+HIo1GyCi9K0UiyKNezQvlcg=;
        b=BL97ABqPlGJczMRDIDfmVHWPNxhBBkUgd/DuH/LieqZsUBCr7lCfmzhpKQ9hHYj30p
         YoC8fINvdZSo4s2TNrnyY6A7Z5c1lKWuqt2NF0CpAGFBcqzdknPZRNRUywGsGVVye60u
         0UKWau3WP0Paf07ykNQoMDCUBl1g1AVRJZ/29pTaruBm29AVzgfpnKdzEeUH914dV9NC
         h5Agl+D8p/42EtSf7gM6REdcACRFWnOsy0FTr6SYHbWm4QdEWFXd2N6J8WRQptLNeKjI
         kl3ZLQOnr67IEHpIow0iM4ATTfuH5cfn4vaiX13AqOfHz78IsxmmxdAyRuml3ps0GH2z
         plHw==
X-Forwarded-Encrypted: i=1; AJvYcCXHtBF6bEbSwZkzi5gMIqh6QlbdVnPGu67NVcRWmsiwfL46KsguakTG4Zfm8JSUVT120Jxo1E7FXHDiaYFpHDXxl/VKCz8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLridKrQHCeNM1+gX9W/YZvcc20yI0c3WHLpyF6GMKdRXZD77o
	OdrH9yCa46PNJfgEc2F6Ky8wySLf5Di//Q+2Voo7yXwD1Oldn106Sq7O00VIfA==
X-Gm-Gg: ASbGncv6JX0K2gMJWSILi3ogZN2SD+xOchY6FaIzfw3q8W58QdA4pPyCeTgaQG/ztwc
	gnShD5FwdHk0wfn17WC53oIdAEWnNQ6eQvWBIxXsFUPncAPOF2dqNCkMZhLE3Fv79X3xQlRIod6
	hDlCQtqaDXl7EtNr70J2KmrWsSRJSKwLdoJ6mCbKDbCM2ubbifGeQAmjxzZIcZNYBHN8eXqI3VC
	OUrzP8TU1SVh5Isgk+xj4Aev4UOXAchRI7jAze+EzmvMNjMv/D+4UvtkK6fUlUyLRUU9AbCcRd3
	A2g6H6NWFQ==
X-Google-Smtp-Source: AGHT+IFs+6UcZosHd2iDR62Ugi6tG8vmQY7p/Mreyxu8ihzV+H08wfaEH+7KqK5h9qrbMMnVoHlMRw==
X-Received: by 2002:a05:6214:21c9:b0:6e4:2479:d59b with SMTP id 6a1803df08f44-6e445a1f182mr86494526d6.16.1738964578659;
        Fri, 07 Feb 2025 13:42:58 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6e44b159663sm8220186d6.100.2025.02.07.13.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 13:42:58 -0800 (PST)
Date: Fri, 07 Feb 2025 16:42:57 -0500
Message-ID: <a4541fab007858c599aed1d1e3e98883@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250207_1530/pstg-lib:20250207_1633/pstg-pwork:20250207_1530
From: Paul Moore <paul@paul-moore.com>
To: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>, linux-kernel@vger.kernel.org
Cc: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Jens Axboe <axboe@kernel.dk>, Pavel Begunkov <asml.silence@gmail.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, =?UTF-8?q?Bram=20Bonn=C3=A9?= <brambonne@google.com>, =?UTF-8?q?Thi=C3=A9baud=20Weksteen?= <tweek@google.com>, =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>, Masahiro Yamada <masahiroy@kernel.org>, linux-security-module@vger.kernel.org, io-uring@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH v3 2/2] lsm,io_uring: add LSM hooks for io_uring_setup()
References: <20250127155723.67711-2-hamzamahfooz@linux.microsoft.com>
In-Reply-To: <20250127155723.67711-2-hamzamahfooz@linux.microsoft.com>

On Jan 27, 2025 Hamza Mahfooz <hamzamahfooz@linux.microsoft.com> wrote:
> 
> It is desirable to allow LSM to configure accessibility to io_uring
> because it is a coarse yet very simple way to restrict access to it. So,
> add an LSM for io_uring_allowed() to guard access to io_uring.
> 
> Cc: Paul Moore <paul@paul-moore.com>
> Signed-off-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
> ---
>  include/linux/lsm_hook_defs.h       |  1 +
>  include/linux/security.h            |  5 +++++
>  io_uring/io_uring.c                 |  2 +-
>  security/security.c                 | 12 ++++++++++++
>  security/selinux/hooks.c            | 14 ++++++++++++++
>  security/selinux/include/classmap.h |  2 +-
>  6 files changed, 34 insertions(+), 2 deletions(-)

Thanks Hamza, this looks good to me, but we need to wait until we get an
ACK from Jens on path 1/2; he's pretty responsive so I don't think we'll
have to wait too long.

As far as the return/label issue in patch 1/2, as long as there are no
other issues, and you are okay with the change, I can fix that up when
merging your patches.

--
paul-moore.com
