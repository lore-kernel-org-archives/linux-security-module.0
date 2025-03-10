Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560811D5CDB
	for <linux-security-module@vger.kernel.org>; Mon, 10 Mar 2025 20:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741637102; cv=none; b=Wv4L6kgRTkNAGFSvLEARAe9fVgplUEYqDYDIqEn7DpsQfOPQc721USBdXCjbf0AzQAHpHwrOPbCOsSoP2uXCgLznbKZBPLdX8WNYnrsvLRRptOFNnMo/e1bnJlr93xYAH9+oArnBu35Ykoz7LC9yc0VOPAG0Buso9SYGaccfRSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741637102; c=relaxed/simple;
	bh=jntbuN3Q49Giey7UXBFVj1qf0QCja1WEmc72IkA3Lc4=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=kMR4EA2KWlma2wQC825Mjq6TAXzijC9HImZIX+uNq4iR0hOr/oP6v5qPbJ2zGRPwBtECL1QuP58BhicCh/zrit0uxjFHzGfWixSEwKt4oaGZx7MiXH7beyde8I/Lo37Ygwvqt5uPO/RCjTbEMsCmWS6uMcCoeVxqf4Wz9QAEahA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=L82hCyKj; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="L82hCyKj"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6e900a7ce55so50203776d6.3
        for <linux-security-module@vger.kernel.org>; Mon, 10 Mar 2025 13:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1741637100; x=1742241900; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QxyEE80JCer8vY++o5g1lXYjyob4ksirUbqlr55vrt8=;
        b=L82hCyKjOiSD+xz3BF8WnJkFvHUHJ4Vi2G2Qsm4BZrucFMdmfdhDMulI3X4esSaQnl
         mDfVKQp58wPd/eb6gVqo6p20bUmAHmw3hn1V5lEg0ND/4QmI4xpKLQQ9FbWf4hiEF998
         f/hU4VHOmeSmpCb0/0b2X1Pt2bE/FhRwBKKvLnQxrSQ55tHRaMXJ83azO02e7uIW8AsJ
         RJjFBy1mI+YeG2wIf77PRI1OKB1e2TtPzjv4lB+GG8rV78sYh1qRnET+vuLgbm0CewZt
         7v/ohaxJIfLGufDX0M/Emi8kd1Fm/O2bBdr3YBgtS/Ed1ip4AtYTDkEzRaPyoFldWYNJ
         qPLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741637100; x=1742241900;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QxyEE80JCer8vY++o5g1lXYjyob4ksirUbqlr55vrt8=;
        b=boe/z/nfQutl73LgzWomRhpA/a9VCDtKf2tbTbvErJwXo5HI3tbGFCU8L/KAltK23v
         etywIKYPfHpBB3CoT0KthmSQOJmL1kcWpf2G6RDR1jIO2VVtZpJ4zsx2ALovIoAkcQL6
         5DB2Ll9H5VXE0Fpeotd3KeZRd2qP1ZdbSaa0w+UMSAzGhQd4VPPK+lY+8caBSgE9guJK
         HPsmz/zRAhuD+f/GksTokqc3CP9TgeMSbKGp/Zfn3PvDfflMMEWa76BhOdqn3cie+2Hy
         n5gdOUlByfjJoSopW2siRucPICc03wZb4zE44N5mjCDP1eVwb3EmCiWx27qPRa3Pk/dV
         S8cA==
X-Forwarded-Encrypted: i=1; AJvYcCXlshdS2aIzvPxO1deAL4HUiQs/5wxcrPL5dQ0WtSRPvgRXsT3IqKTIe0sqYgF2cWMgGjrnPxoDtsfc/UiuuWUJbdNj+zA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwR9Ax4erTC9yV5nZKsVSkkiojl8kR+OuxJ04yy2AhSOw/IIEoh
	BWvTIqqcSGJOHkYP2G1FqBZ6tjjPDE8ZTzqIZlZs9ng6vCLkAg3BGdrlphWkXU9w0xOpavSbhhM
	=
X-Gm-Gg: ASbGncst+cwIpBHaYtLxksFf8byAbwuTL5cAZFRdoD3qdTmQwFJfjy2ke9Y0IhEhKC4
	+PwVn5o8ClbYHXVc38Fzb50dNW9IKQQwlf4R1HI698zPcLm17juSFJUZ9VjPRoB8RSi8RFoAhI+
	eCsGS5sqjwfZ3iLX5yjy8ug5GvBzqpDsXF2yTPcIip5RkGTz858qj0wfV0Q/EB814jO2mqmO+cM
	78p7TUBZpFWzly04l2EqlRALck2DXsUDVuzZrC0Z9F5+Xh00fu0wVX8rtIyn03f7IqGLt3dNxTx
	Vf+tCfoLilujmn6qA4PWaOrAJGREkKNVVT1QdYFH+7E58hLYtW28Gu0DAz6DaZOJ0Mi3fL9CbUc
	WmUsonItLJhrIQg==
X-Google-Smtp-Source: AGHT+IHu6Z3n2avDyO5R/o+KUXX6uCrc6tubvLtM9wLLG0yjJYhoObPUPfQyerijgwG8oq6Ngep+kg==
X-Received: by 2002:a05:6214:326:b0:6e8:fee2:aae4 with SMTP id 6a1803df08f44-6e9006ad479mr179970716d6.28.1741637100255;
        Mon, 10 Mar 2025 13:05:00 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6e8f716eef8sm61616336d6.94.2025.03.10.13.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 13:04:59 -0700 (PDT)
Date: Mon, 10 Mar 2025 16:04:59 -0400
Message-ID: <14321d4f852aff00173ca711fd86fffb@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250310_1216/pstg-lib:20250310_1216/pstg-pwork:20250310_1216
From: Paul Moore <paul@paul-moore.com>
To: Stephen Smalley <stephen.smalley.work@gmail.com>, linux-security-module@vger.kernel.org
Cc: serge@hallyn.com, Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: Re: [PATCH] lsm_audit: remove old email address
References: <20250310142410.1667-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20250310142410.1667-1-stephen.smalley.work@gmail.com>

On Mar 10, 2025 Stephen Smalley <stephen.smalley.work@gmail.com> wrote:
> 
> Remove my old, no longer functioning, email address from comments.
> Could alternatively replace with my current email but seems
> redundant with MAINTAINERS and prone to being out of date.
> 
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  include/linux/lsm_audit.h | 2 +-
>  security/lsm_audit.c      | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Merged into lsm/dev, thanks.

--
paul-moore.com
