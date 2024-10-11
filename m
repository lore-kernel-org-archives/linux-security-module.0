Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25CDBD268
	for <linux-security-module@vger.kernel.org>; Fri, 11 Oct 2024 01:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728609653; cv=none; b=GTbCreR3Yke6JSqJCj6rMo8+ku4hKM7QUSvwK9oZY1h+1AfD6TnZ6oabAmiy6mLtxAATn58VFOCnh2eGrPW9SsGUDbNBQWtPArbMHDzh8LVnrYEghMcmyCewpOJ21w4F4ClaFwU0Ijjn0KvLZ5tL16RXwR71aL+bxW03cTkN4lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728609653; c=relaxed/simple;
	bh=yslYLZ3UmvXQ3tXwi9DG46llkHldFxew638wc6nmTfk=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=mh8/+odBsWzPjlvjPyY+vDmSRqYY2r1+smmJY5imaDcdA5pW1/DdUtLUGHMPtCVlXVg8ZWpOZzO80dGHNQAZQ+YdCcOPcuOjjJmG/AbTlbVR8It2Tt1/AKzS8Xo/+a0rvRrCxJIfLmUfDwdgE4vUd3LaRVaznsgtjF3hdQBCHH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=M/3NUOpU; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="M/3NUOpU"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6cbcc2bd800so13924176d6.0
        for <linux-security-module@vger.kernel.org>; Thu, 10 Oct 2024 18:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1728609651; x=1729214451; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DSYc5T3VWRhsmruLA3gY07A0OlNZL+RmUFs8WfbL2kA=;
        b=M/3NUOpUqIoQ77RRYcYI/jJyZ/Xtik7haqQnRIc03MpHO+vtxDG2so4zK5yXMlOE70
         esudG/z4yLG0d93IWpHOIDMhnwsPhvUSVQKzYI4U+RDv9nSGCIMc1aRQ8RgzC5/wTPO5
         HmOyi5mXt6Ny+XHkhUuDcMaqWDk917J9DPurXoUOLSIDv4k2rMy8mK5O6tsbdHqgbNAt
         qsWSihDuCmm2NYTlAhzp/Ysf1wkBA1JxdPenX97Qf67FGbBgF61TxwWWj1mK0F72B0OU
         daZDc9DYyhJMId9SRHG1EcNLVI9r4z3RXRwF37OnDmv8CRz2LjSmJpk7hPPeAueeZqPG
         M1Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728609651; x=1729214451;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DSYc5T3VWRhsmruLA3gY07A0OlNZL+RmUFs8WfbL2kA=;
        b=H7Ac/J4xKurFD/BtQaZJR0ntjGJjERKtyrruQmomg7RL5DaH0c3xN7yZTwNhdd/ZNt
         lU28zYZ9W9BCFnhbzGsDf4aiP/+IANEYYhpCPtjrNnJwvuP0Us2Yrat6Y6+BjRawc+7h
         yvOjKWe6NNhprGa6LIDp5YFh13YsbfWGVgd9lp7WjK86jpgESthK4r9rC3vn8WEg9vBY
         ayWmlisy5knoIGaMI5JzOH6Cn3ChwXSk6oARR0xXs/uzeAz816Eg8y96PlH1tEeNLTM2
         yH+wl2vOSTi5lamTzmm2OGmqG4m2uuXfvQy9FMOEgELXqjdlf2xuCrMcIaEpVMT2rbZB
         DXUA==
X-Forwarded-Encrypted: i=1; AJvYcCX2kfwLboXCqTtR1sikTRqYne03FIMNFikN2lEAfeH7v8f5L2iTgrGRudzsldyrCkaWVlDBXnJmr48WPgJ7nv5gKLxI2IU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzxewFNm2fQbaBANO5ug8zPJaxLlnAZ5pqYMgkS2G//T0CcTZD
	RPIebTbzF04cwagu15rt1nAhiMPQxNeBVjjqys5R4b1Fa0yV76p3Ur2BLGL3xQ==
X-Google-Smtp-Source: AGHT+IEqJeWFt79nQGeuR3bq2NUHrSRVHy+WW2D2IxkX40eKx9WlSMBeeYzd4yPkBCBf4eMRVOJxdw==
X-Received: by 2002:a05:6214:498b:b0:6cb:d3e2:ea0d with SMTP id 6a1803df08f44-6cbefabae20mr21350876d6.12.1728609651103;
        Thu, 10 Oct 2024 18:20:51 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cbe8608ebasm10941006d6.80.2024.10.10.18.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 18:20:50 -0700 (PDT)
Date: Thu, 10 Oct 2024 21:20:50 -0400
Message-ID: <c4260a81d3c0ebe54c191b432ca33140@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit
From: Paul Moore <paul@paul-moore.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>, Christian Brauner <brauner@kernel.org>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>, linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org, audit@vger.kernel.org, Eric Paris <eparis@redhat.com>
Subject: Re: [PATCH RFC v1 2/7] audit: Fix inode numbers
References: <20241010152649.849254-2-mic@digikod.net>
In-Reply-To: <20241010152649.849254-2-mic@digikod.net>

On Oct 10, 2024 =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net> wrote:
> 
> Use the new inode_get_ino() helper to log the user space's view of
> inode's numbers instead of the private kernel values.
> 
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Eric Paris <eparis@redhat.com>
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> ---
>  security/lsm_audit.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Acked-by: Paul Moore <paul@paul-moore.com>

--
paul-moore.com
