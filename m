Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795126693;
	b=x1jaNLHw1cGaO12AqNAIvMFyMWN0Iun5K8qxY1KgE30y7cRZZ1Zz0GOV2FLdaMXp6+G3
	 YaTRFMQgYHs3QajMkhKKoV6AyqTtJjgtGjIMymino/qgcuBxSJvQMzmBeQtTjWrNwYOxL
	 Le2V1s9uQB9bOZDkI9OQwb0uBbhFQyFDXhvANqyqqrlipsbaWoYSg2lWAt15VURVyQivb
	 8ncQfNfLJcH6fA8m3llHQ5JZpK2nbqOyQ/yz/IMUQHPM9e8Be0e6q/M+o3kCNDzlZIeFn
	 VCx0/DFRzlqeNOGmm3Y/asMbQQLETsPTHiScvN73QByfcJO35MwbPLK70ISPArA9P6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795126693;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=gA/aemZzQ9sPBTs414mU1ORatQGaaPpP3nEzIpSAJk4=;
	b=OwJ/+Pf8Ae1mx3hzIO1uTx9McQ+M7xvgzJThufsfGTLXdcjt/F6jmuadh5h98t1jx8f6
	 VBtuMVwpYAVLMZXCs9QnNfl11RF+sMu/7HC3+a7yupUJMbHxyZoh/ChCIaCpyOcuX9uk9
	 YpRiLH4FFcQA65HAoKmgx0lyNfYh2EnDzmt3xKRJcjJfUU+0VwJkexP5eCLkWknBn4l0T
	 m5nlqZB1ceN8yel+wvDKFzCgABiWmnmVjww7Lw33yQGdgBfePCx7eeNEKkNq5AqDvXp8n
	 E7iBDkIxDZoyfyu5tcViyn0U6+EX9WMUNJ+fX3XnEeKbJM12mULs8PMS6zcGLBYW32A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-foundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=ZldscqM+;
	arc=none smtp.remote-ip=209.85.208.44
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FFEC606A320
	for <linux-security-module@vger.kernel.org>; Thu, 19 Nov 2026 22:18:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0FFEC606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=ZldscqM+
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6b587538a37so352420a12.2
        for <linux-security-module@vger.kernel.org>; Thu, 19 Nov 2026 14:18:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1795126690; x=1795731490; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gA/aemZzQ9sPBTs414mU1ORatQGaaPpP3nEzIpSAJk4=;
        b=ZldscqM+w6KlyLRO82OGvVKpcNkMDSlzQnlKm1Jy7mLtXSui+gU2v6CYgiVnnKXTdn
         9fzbQjkCRQyAbCXyKCWlAVC5b4UoUNY01GgGaQatwW0espx4lbEMhEWhqL1PnAv0TRlJ
         yWN4IxNrJApTOAM6TRrnJ4nhKUWJhJH42cXCY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795126690; x=1795731490;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=gA/aemZzQ9sPBTs414mU1ORatQGaaPpP3nEzIpSAJk4=;
        b=mdmkLQnINXWN3unNW/KTGo5CLeGUnuqc+yO6/uulRWf3WcidZPBRY0XMP4y6V60i5w
         o/ls2WFQDElq5B6WSap0Y8MlCO05LFwFD6SdY968wbOCHmkT94miH+bjtpKQIoRRQrP3
         VusD0i0fROMYSPyE1yAyCJ3vVqDYwiDVqgfGyIvjJ5q/iqTT5WPDLiUqtQlnTrr9PI+c
         3xCPLikhAF3Sn252WRDvQisV5yKD5IzeprXkaUAjw5p8shkb/l+8fCpZQybwavNslFYB
         73NZtOq1JcY5tuHkAKfL2E1p9bJcTYEorB46jqn6/WZ3Bf1gvmE5tlLMAAkyBdlz7Hx6
         99Yw==
X-Forwarded-Encrypted: i=1; AL+hErHuLn06F5+C2XDQ8NgIUadN67fFexxl/d48IJ9mErakl1hRbv+1kyCLSCHiu9BotlhWmgDfZ7SRQH5BUc4qhOkdh+5IMJc=@vger.kernel.org
X-Gm-Message-State: APuU4Z/RsEpLLHRJAUuLQDSRAwPzfPyBm+e/o6FC5K51rSO99WJ1+fC0
	uALoN+xXyJK17iUfKLUZ7PEiX9k9DzSy25IWKj0ttP7nWW10KuEYD6wZF1BaC0kr+/9S4vlJPWy
	FCS/g6ZE=
X-Gm-Gg: AYBFou3RRO2QAatgoDpcCvdAv1Igfnf+RY5jS4kQvTOPnzyRmm8alh+pdKiv8EW/mX6
	/v51jllUVzponiFhVb3QptuMT8khvDRGLgS1BWqYUK3xvtAiaMxKPpyuVZosJnaa2oZFqZZcMTv
	sRFRvYG+tSCUK7eo16NDZyVpfg+9vejq84BE4mO9wROcm2xldj2wFH4o5fV9wcyarDBWDZz4Zf/
	3DB7XVaIQkgtDU9Pt0140uWSVTpR/6yuctfIy7N8vXOJ8ghMnD8MZ0B1m7ef5Vbh2r7JmoNYtS3
	LCDabnm5g2pI25N9ta35EwYx8FFywIc8otqgKmMYRGxbwoNQ977AmXmKZSCDis2xPFGQstOB7U8
	/rlZur5UTceyYAGogQZ4IpjpM5hN2lFE2Qdp3HPhv/QV5FCQv4/8T/LkiKWO7VVXW0Ehao4TbXY
	UaqQM47DSRfdFIRkl8buo03ywckeIQzyZdRZXO32gGdcBr1xYFEeggXlsXrvIg/K3BIAEHOmtvK
	edg0YMHz4VdB88Xa0GxBKDzttm1aMqIaFVoWCm/CTQrle14YNGEcgjSAZlQro5Zk9V5sY8WwMyc
	rSH9TfkhEZ6qgWKg/lFQC2z583g0EGp3P+oQMbSuNpe7DmNCyPey5mn1wQVD87LzDn0HTlgYw6v
	grBg=
X-Received: by 2002:a05:6402:400d:b0:6b7:b872:27b4 with SMTP id 4fb4d7f45d1cf-6ba37ea34c8mr549140a12.21.1795126690396;
        Thu, 19 Nov 2026 14:18:10 -0800 (PST)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6ba36e355easm386690a12.3.2026.11.19.14.18.09
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Nov 2026 14:18:09 -0800 (PST)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c4cdc606b47so54151966b.0
        for <linux-security-module@vger.kernel.org>; Thu, 19 Nov 2026 14:18:09 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErGB9aywFmRrq3YhtGZD7ScrvNorLPNYZ96Od3Ji1ho8exXYNUJivaiQSU5dxUzUVcR+1GmYe+Pqpgj17oRdkqlqKWloFyI=@vger.kernel.org
X-Received: by 2002:a17:906:fa82:b0:c50:4b6e:329 with SMTP id
 a640c23a62f3a-c513a5eaea2mr95509666b.15.1795126689675; Thu, 19 Nov 2026
 14:18:09 -0800 (PST)
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <d583b944b32f1a6f9bb27005d628ba9a@paul-moore.com>
In-Reply-To: <d583b944b32f1a6f9bb27005d628ba9a@paul-moore.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 19 Nov 2026 14:17:53 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjUjMpcaOikkbk-p9ohKdOO0yWX5KW7LGUJmGZcKu-gug@mail.gmail.com>
X-Gm-Features: Aa3M54o9ZC0IsT5wgB2P0cNNI_yXbdHzih86Soy1GWfvNitkqUbm-kcgwt__74U
Message-ID: <CAHk-=wjUjMpcaOikkbk-p9ohKdOO0yWX5KW7LGUJmGZcKu-gug@mail.gmail.com>
Subject: Re: [GIT PULL] selinux/selinux-pr-20261119
To: Paul Moore <paul@paul-moore.com>
Cc: selinux@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 19 Nov 2026 at 13:22, Paul Moore <paul@paul-moore.com> wrote:
>
> A single SELinux fix for Linux v7.4 to fix a problem where we were not
> properly handling MAP_SHARED_VALIDATE.  Please merge for the next v7.4-rcX
> release.

Bah. Horrendous, We should probably never have passed in the raw
flags, and instead passed in the flags we actually use and have
already generated (ie 'vma_flags'). There the test is just

        if (vma_flags & (VM_SHARED | VM_MAYSHARE))

because we have already decoded the odd system call arguments.

Oh well. Pulled.

              Linus
