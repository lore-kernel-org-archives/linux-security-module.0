Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52099387377
	for <linux-security-module@vger.kernel.org>; Sat, 23 May 2026 12:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779540045; cv=none; b=rTPt+r603ow+ZMIYomF+nvHM02PdwnLaIzUNMgqkGA5otDkYDS7iVXLh5UFUltzUeCuIrSnKGpbPo651k1I/+0XYhQgr+WEQbzZk5OONjBQ8SIEtsvRrAe7UzPsjXsG1o0g+NdSQCDT8Peq3gjeIpN8IZkO2bf1suJewCIT/w3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779540045; c=relaxed/simple;
	bh=Ehxr5ZZxvn0wUwMUfOy9afLMd5ZU5eM6FSLjW6I3Nes=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=iDATEYH0Ia7ejJXjdlZJuB98aNVUyH8GXAlIINmVLtXanx6PwGWS0NTSmeR39uTu+URD0jIwCV60YHJYlQqnskzo/Ely95kICwXwQ0q2U7RiYj5+o38QWGhIp+T3OModIlvWCxLXjMbfLpQOcO4KD2wVWEFapzxfE0uZwclGF50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=WCNu32yC; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="WCNu32yC"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-5148cbdea08so69021131cf.2
        for <linux-security-module@vger.kernel.org>; Sat, 23 May 2026 05:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1779540043; x=1780144843; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r58xVPNF+m0WFGkWYL2Am/X2Rl0rlWvrIW8LmGz9DRE=;
        b=WCNu32yCiv1YXVEhFOy7w0t7hQ2sPcbAV920Q3qZ8dqZiFAtNx2rrt9J4QKM4yD23v
         fgv/EFoKou1dpN7ixN8a34mWlnord6foMhh2b7v428twmP+whydYWUmXCm4H0//KDHo7
         4Ha+f2c2y0P9lcW6NUeyCI5KgBarVZw/KgXNyhuKIqMAcQlcq2BViK84fDrISUoE3gZg
         uiEZU/JDUfcuib5xj708E/jWNiSusfWLF9Dpu+1DggUvSLq8UcoyqASP/g7yvxynUej5
         ifuJ05Sl8ZMJtl15doEpjTxeyWMrWg0gNfFnhcA0jM4CrSPeUtRysvqSDwXFZyq0YcEo
         ao1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779540043; x=1780144843;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r58xVPNF+m0WFGkWYL2Am/X2Rl0rlWvrIW8LmGz9DRE=;
        b=hzJsM+vVwXEgZ+4QMbIyfiRFZbn5jIMR24dMaQasfBvSoduIG+snYga5VXbY0wVj8c
         uGb3jwmDdtx6qOfphxQodwdDwQW56dY14+N4qnZAmi6zClgkqYBfL7Oi6YOo6wRnuz0x
         ILcGLpX2p/cLhWAaB1xil3WyQhcJWq4efQr0X/wUbTov44ud2TzShgLV4vXrhXpHFIPG
         Iu0ppP0vZ6gCQW+F8JYzS7UHR7DNuI8/j/qnDR8v6+/aVxgeTr7W359dT8sxY5puaVNr
         hoQnWKuDwZ6BN/QGaD6szzQAzEgjcvgPwrmhwBfWeXKe+eWmwaL4Bj1qz8xUZtSVt7iN
         lHxA==
X-Forwarded-Encrypted: i=1; AFNElJ8pljaJDggNt7/zNSS/D2PW3Yl9ykZ/R94CffrnGpj06NLVXlRkeKkXSxXXfnAudosGENhQ4EyT8d9aXHt1wf6vp5+NwPQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuUcqXeFDr9nLk/1UtWsLpP+dYGMuN/655x/CwSNTVgBYj/KJj
	r6p8Qf6gWY1DDyoAbUJU72SkfirF8bg9gPS4rDzwD1gL8ZyIhTOAwxwJlSSmAJin/NGJtFDem3n
	JE0E=
X-Gm-Gg: Acq92OFJyZ5GVp5xoFT1Q4mhXEPdcLwSIQA/ETb0tInX35gcP8dfCfjtm85Z7Iov36y
	xpbJosO5ZAgsjvBkLfaz7n/csSAvtLjXltnaBU8L5H/QV7pgAFV1mChCCCwgSYbhbRVOWMseMfN
	oo9CVrgdR2yod/L6PMuiV6DpZIgWyMLX70e5b9soTqIHEK+vS/AQc+YmmwQE+RktwZ1kQEVOp3T
	AAPia7KSxAfW6AM3quPK1f3pO+Hz+fa/wT6M0MlTLm9CKXmU4W2RG4pONgc0lB9VhEry1pC0x0U
	DbXEkGSoVQ7j2ALQcOSJqCQN4HlRxVUYHZWXyo47Wsg16zyb6u6QxfPTY/aKazleiJkz73ehYZz
	mtVjUuggHXIXaW39ycVCos434GknrbjAywpa3M8uKGDqS4WIF2yIeOEAm55wdBKXrYTbK3Ksu37
	r3aTCCjdv3Ma5vpL9EYMyDBf0=
X-Received: by 2002:a05:622a:190d:b0:516:d955:ea2 with SMTP id d75a77b69052e-516d955144fmr78384601cf.0.1779540043159;
        Sat, 23 May 2026 05:40:43 -0700 (PDT)
Received: from [10.234.26.20] ([108.147.98.161])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516d8c91c42sm39025591cf.14.2026.05.23.05.40.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 May 2026 05:40:42 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC: KP Singh <kpsingh@kernel.org>, LSM List <linux-security-module@vger.kernel.org>, bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, James Bottomley <James.Bottomley@hansenpartnership.com>
Date: Sat, 23 May 2026 07:40:41 -0500
Message-ID: <19e54da1d28.2843.85c95baa4474aabc7814e68940a78392@paul-moore.com>
In-Reply-To: <CAADnVQLbCz8nCLS2W=Hpk3hVSBqHGuGyVjeKYPnNDhhu_1UiPQ@mail.gmail.com>
References: <20260522023234.3778588-1-kpsingh@kernel.org>
 <CAHC9VhTk3qovnQQjK0C_FWU605j6Yi+-poMVVMS8WycRFg9xhQ@mail.gmail.com>
 <CAADnVQLbCz8nCLS2W=Hpk3hVSBqHGuGyVjeKYPnNDhhu_1UiPQ@mail.gmail.com>
User-Agent: AquaMail/1.58.1 (build: 105801620)
Subject: Re: [PATCH bpf-next 00/13] Signed BPF + IPE Policies
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On May 23, 2026 3:40:46 AM Alexei Starovoitov 
<alexei.starovoitov@gmail.com> wrote:
> On Fri, May 22, 2026 at 8:56 PM Paul Moore <paul@paul-moore.com> wrote:
>>
>> Blaise has recorded Alexei's NACK on the Hornet patchset and addressed
>> the TOCTOU that Alexei identified.
>
> It wasn't addressed. You simply ignored my feedback.

Blaise most certainly did update his patches based on your feedback. 
Perhaps there were multiple issues that weren't communicated well?

> sashiko spotted it too.
> All other sashiko bugs were ignored as well.

Link? I didn't see any feedback from sashiko feedback on list and to the 
best of my knowledge it hasn't been enabled for LSM patches.

--
paul-moore.com



