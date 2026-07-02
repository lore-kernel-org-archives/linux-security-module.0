Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE24F34D93B
	for <linux-security-module@vger.kernel.org>; Thu,  2 Jul 2026 18:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783017395; cv=pass; b=DHulcnMYG2qsZPFNvnXw9pg8YlwiT1RFzvqhYjQP3bhZ8hqql2orTm970k2BjBQ83WFy7bAyMFJWAR1hCNWJF592ZZjG9VZDmniwARlSNlo7KgtbyaKhh9sM6q7wn9xhRWmJ7tET9GmAfpuU6rCJHMrsGOpKhvZcXXr637DFP3s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783017395; c=relaxed/simple;
	bh=PCLOCX/Eob7+UKaMpmopGS629KwyCWVOuoZRf07w48Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=THT9K4jehb21kffEkCMoxbqvVtZdg2FYMKaWYASuRE+7QEQcK7bOu/0rO2dNciS9WWe4IoaBn+6Ix395cQv0tEGts5/kDVqVvFY01E1NqwWzAZGtbb1ln47Seej2VZrC5lrDm6Dh7monqZTewEXs2kfXCLZ1tuqmO3EldgvV26w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=RBNjGbk8; arc=pass smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="RBNjGbk8"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-842338c18e0so1541641b3a.1
        for <linux-security-module@vger.kernel.org>; Thu, 02 Jul 2026 11:36:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783017393; cv=none;
        d=google.com; s=arc-20260327;
        b=AjVXXSQbV6+oceNcI4/cHV7RWsq7OX31mOIDRf6hN5CY6XZB/lU8pPiJXsn6EVSk+n
         Dk2chWXnAOtcSP1+R+brVViPHPaPyiLsFZiFAPg1Uvq2dKkg4kn3SLy4pspqS98t9PKH
         3QbDSqJZeg1Tk0WGEr+11m+PR8NQH5JwIRWq9VVxM3/Soo04bv+1NHpmrstUQOUPmRLW
         AAjcu+J+OJjnCaMTvGe8n6iuQl2sjvwH1eEN6Q/y6pL4W+dtvtbvalpAtsNU3L13lghT
         KDO5AasE0Z5ButPeEZH3rJyMQZ7Cxl4YuvkZ7lxm9/Eno0/cusjaF2RWjYgUABA0Zizm
         bdPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NEhwGG3IOip9xw+ht5KLaONZ3M052iL+ytO4+Vh6eQQ=;
        fh=ojDR6lFZdKSTJhrQN+fiDJ39kCzzpxpmGQZew9QLCjE=;
        b=amyriYXPDuAxy9/LeNeiiY2ZEeiNXwRQBYV5tAmYHxJUuNlZLlDHAzWkP1EKmE8sAO
         Cn7zptjgmkD+Y6ocgjtUtafc3p+i1kZpLP32HzAq6h1vtgLbvzbeQNkJdytqOEKk9S5H
         dZ1V023jUJvoKT1meq4r/HqHHXP/8NNTjGMYwdu3XWPDTP58o4ioG0Cdl9CUMTpt4w0V
         RLeK9aFUlTNggQaraFpP2J12SYpNBnbUXc90xhfH2+RHTp93BOOOcyUlO6OZ5gDAL4zO
         gI9zdXZ2Q9AUFO3xbJtVNTsyrmpIqKxOtxx6w8IF7ZTAsyZSM7DfQfOoGn+QeH+HGVGI
         Ik4w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1783017393; x=1783622193; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NEhwGG3IOip9xw+ht5KLaONZ3M052iL+ytO4+Vh6eQQ=;
        b=RBNjGbk8i5/xgotV+JBaOfWeSOdDiynADhSQxWoRRSQMuxEi3WdOU42fs9vBQhXdhs
         YhIy2A1PmuBEwa3TBr0qBITZpf0LKvvtbf/eB5s4gWWwd0NYZgDfsAQTQKQ1ELGhODDb
         phHTdWZlhuflWfxQU/nyzcyD08ql99iy9nv8tzdUXFDpxdkaVaM5DncklG0jbTd8xLuT
         YxcNAovY2kc/Eegyv7QE76FsbGUFLEGbGtD+CbbAJ5nGuocC4VOrChCE7REe3YMJk21S
         p4hB62b651Zz2ZgopsmHvXpOjofboKNNRId04EAbAg6tlW9Cme9+Woy+fBfomWyMi/1O
         5MsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783017393; x=1783622193;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NEhwGG3IOip9xw+ht5KLaONZ3M052iL+ytO4+Vh6eQQ=;
        b=PdkXWBb7iAgURgUIwl/BJeLkOkCzOH6bDgWNGs1yCbo6lH+xM/t7c+DtIQIBFvL93e
         z0ex9s2MNqWZB3QfHdg5asEtdznn2q3cGSeu1EosF7fjlWnEoJtqcRwhtLTbRWumjQM0
         sS2T+tghiUOu2OcJ5noiO2gM5UKqA9BtRE8RdaS47gf26a4TUwnRJ/4J9EDMj+5PjlFP
         Qm6K/+lfgq55P+xfvXWufj51WWpBfqihZz9hxNXLqUmGOeuwSja24vT4P4FFoAffva4n
         YImvzmxsQlt4c0WI+lDAp29xiEGwVvTItNbUVq4+x33rSHtVr62qwiK6jC4KiFySBwP4
         cQwQ==
X-Gm-Message-State: AOJu0Yw0OvQSQjcjOdRewS61/ycUmQ5DtG/acs4i1sTS2KAgqDFuckoK
	QgoHZWCmnR9i4qH9tx8PbQKzfbXrPmPk9I2QlEhjaJOBWPbpJEsvlWtlVrKVUZce1yKMnSPJxJ4
	WWifIVAKt+7J8+H7MYFjpl+fxAyzkiWxUfoPkzNC2
X-Gm-Gg: AfdE7cnTbtdNY1d3wEA2jlucUPe22nOSq2CmEtaW9VbEvUXhe+UMLG+kj2QVT6wjJbo
	jw1/rRMA+2PuElkqC4c1DqKZiR9tAh5VvsAOOCiApzViV4xLQVzfC0j+lr6+5Aeus8Gpz+fKUlf
	LfCqJwi6po0zbbBQjUuYRl3PABJfd6JbVX+wr9ZV6VE6UiAtk1h2Z1mNjd1EkKm24A+QbgXJYNU
	hjpcGl/wxHcCbCY05Rz6+mPOzevSmyLgIPQKJgl/WKjtklvybByYdtY203v7PvKJ/KDovjc
X-Received: by 2002:aa7:88c9:0:b0:845:dde9:ab62 with SMTP id
 d2e1a72fcca58-847c07a0812mr7482037b3a.19.1783017393051; Thu, 02 Jul 2026
 11:36:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260605144325.434436-1-yeoreum.yun@arm.com> <20260605144325.434436-2-yeoreum.yun@arm.com>
In-Reply-To: <20260605144325.434436-2-yeoreum.yun@arm.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 2 Jul 2026 14:36:21 -0400
X-Gm-Features: AVVi8CeOOyE2Od7gNJBo3j-LLr7BLyJYgunVuD-VezKTeBhB5ZlmzgqKWCJuEks
Message-ID: <CAHC9VhQXwXHjKcr0SRNQyzKZgCwG1RLPT6kWDLLwEKExfXzzOw@mail.gmail.com>
Subject: Re: [PATCH v6 1/4] security: lsm: allow LSMs to register for
 late_initcall_sync init
To: Yeoreum Yun <yeoreum.yun@arm.com>, zohar@linux.ibm.com
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-integrity@vger.kernel.org, roberto.sassu@huaweicloud.com, 
	noodles@earth.li, jarkko@kernel.org, sudeep.holla@kernel.org, 
	jmorris@namei.org, serge@hallyn.com, dmitry.kasatkin@gmail.com, 
	eric.snowberg@oracle.com, jgg@ziepe.ca
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 5, 2026 at 10:43=E2=80=AFAM Yeoreum Yun <yeoreum.yun@arm.com> w=
rote:
>
> There are situations where LSMs have dependencies that might mean they
> want to be initialised later in the boot process, to ensure those
> dependencies are available. In particular there are some TPM setups (Arm
> FF-A devices, SPI attached TPMs) required by IMA which are not
> guaranteed to be initialised for regular initcall_late.
>
> Add an initcall_late_sync option that can be used in these situations.
>
> Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> ---
>  include/linux/lsm_hooks.h |  2 ++
>  security/lsm_init.c       | 13 +++++++++++--
>  2 files changed, 13 insertions(+), 2 deletions(-)

Looks good to me, thanks for working on sorting this out.

Acked-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com
