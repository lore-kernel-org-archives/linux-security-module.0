Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129F6280317
	for <linux-security-module@vger.kernel.org>; Mon,  2 Feb 2026 16:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770049191; cv=pass; b=O1EqpeuXunKd1XUBGgJY8k4fQBG1Gq92VtSeDmlIIQRAaEDWg6rULoO19sMJ8mqHz/pw4CwImMEj7zzJJUaxgsjzTzR0vWjOou4ytv/dbkUfnz+4wPBdRTJ5ZpAfGE4el6TLJcSgB+O5/q79RpzIByOwbrns+1zH2hdnWJ1qoYw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770049191; c=relaxed/simple;
	bh=c7d0r0PLLsqR9eDDmZQQkdYbIRqemPUtnCb7prP9kQU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iYnnCmDKA0o9AxY3zF08FntcR0JiXQYAot5E0SDTspNmbLzAtH/PuCHa/ZZIqRWA0+hmcPzjtzikGiA6p54wAmUNygfR2MQ5KhfH0xcuWwEbVGX1XCs5vdp/zQk9cpCsqhzwFmDXgcW1Kft+JILtprYE3Hf1hoCLEyZXTs3XAaQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=GfYSdDHi; arc=pass smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="GfYSdDHi"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-34ab8e0df53so3887376a91.3
        for <linux-security-module@vger.kernel.org>; Mon, 02 Feb 2026 08:19:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770049189; cv=none;
        d=google.com; s=arc-20240605;
        b=MBogOtsHAA4NLKyNgfwK0UbpLqoR09mSRNpjbnIndRIJ0USLXuHGGBKR6ofg7rBXAG
         OHqUP61sAe4jvJHl4CKYAIHcXIZuEF9TcmzU+o/ebF8vwkTgbOsFBMs3Wk9rs2ToI4pW
         BuKfGE8NDQnrHLy2y2Nb4HFCqvlTmJ8Opgd6Pv6M50WEzIdtHLzNuNqi2gc3/5j56t9p
         IvXPsAJQq90C+BFzhgyhkidarR0wM0FcN3eCnD84MSWn3I3HsYhS4MzQimmvP8LyYXfX
         YaK0y9DPFrr1YXFzWNYVn3VrwgzasWeBWYvLPPTdRHWK2+QEDZxQrgLdSMKNoM4VGgL5
         TZWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9wA1o/Co+V784yYc7kKaQ3dZ9Xgt1av7TFvzMkqxsl4=;
        fh=39XAcKDG9DWgBGl2KxW4Wh9SASXc0D2Taw3/9Wy7yug=;
        b=LfuVlIp0J/Ydr69iGd9zY8VWJ0ehuYlK4Z51kyHQI1+N7X5uRjw/rxVofv+1rGBryE
         qpG7DSusiyoPKdaXXKNhyihwV1q5uRNKijJpHW0jFvJfFzPaV5xce9mr8G9TlGxt+wjr
         zoH3Xsrk1+RdczEjwyXIBgrNtKHx4pbCMRqMextI47rMEIAZvt8XL/i9tG1Tj4P4e4Dk
         UzIWmOtCnYHXN5Ob7kYNo8hD8p/MySkEhuBnXBzsnjzNHY6GNEiKkBv8h5GjbbyMurXR
         +6w7OiTxYUnjPEUuRbF1+CKQEVBtlvw+1hq/wzPnNsyotYzW7c4BGrwxuHzyOpFBrDdi
         Q2QA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1770049189; x=1770653989; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9wA1o/Co+V784yYc7kKaQ3dZ9Xgt1av7TFvzMkqxsl4=;
        b=GfYSdDHibpxm62LN+bWlma3+Aj8Cvi45CHeSiC/lbaJCqUDdId20koy7y6dCtRqiUm
         cmHiVE9GxsHzU0bUjRzmcjg1BKCpefqucMfZhw1ii979zghzoFzhvI3fGRq2BFvqLvxr
         RR5GG4msi121ZX8BzY6x19uBpZPvbTq89+3lF2aHF12RGBy2OwqNtuHHUBUwdLrWWPEK
         u08PXFqYOf5O5RZnFl2zjbYzvsSdTu1ubxyVF9CwQOK3koGORquqOpMhAIWvX5gUPOiu
         iTqgAmulauMOpAC66oNdLjyH1CzEbP402rgcnfIOUJUxfc/xsrU4LQbn31yMSAeLSar7
         FfPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770049189; x=1770653989;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9wA1o/Co+V784yYc7kKaQ3dZ9Xgt1av7TFvzMkqxsl4=;
        b=ADGU+MveEjGDsTcvJ4fiQ24BDLirvj49zc+aJQ0FD3uCgKVA8Yci2VB5f86he6sQ9g
         4lyUjetVzunTV0lcLVAAqK02y6lCx1l74zQYsLWC1LRCrWOP9JRblS1zSyEw9GRRXAsp
         HJ7glkm0TSOQqMzs1eaXYCsJbZNeBzifzd1zxxpLfH8WUHH6f4whGion9B9hv4ARZwsX
         2TaXXUx8r7X1khRWDwi+PXi/R5tz5X1PUhQnXvEnk1Znu0vo6xhaZ7MFVM1ntJkHoLOs
         VE1cfn2fzTNjiPadmNVRXDkFEsbGrhnT9JxVgOi8DUiTSJeQcJCS+eRqJUOrDMqC4PgD
         hUCg==
X-Gm-Message-State: AOJu0YzOIr9T/UR7sec4ZrqSdfd/23yP888wENV1YE2SgSFmtfoZVRd3
	2t5fini+ywk/RBuD9fhwSYAfNZDyLZ9wA/eoYn/IP1V/EV2fga/e4IwfIgi9oY3GFJjUhHoJLjo
	67iAAnmSn2yERohJuPcOlRY9lJEuxKdOXBCsl6LGp
X-Gm-Gg: AZuq6aJTG/NRW7+e6U+UBZ3o9I+btwd3auqGIREi2xLMrq3QJGMjtV0UL7NiCMXaSww
	zua1yjdmCEVRzqtWHAVAgP2o83RFnqgTJMID5Mu1H9QoC7b3CWx1+SWZzpRCwjYqI/IqA/8Gsja
	1/nrHWHaKJ+6CV9X5d1VQpmi8/hEd/r8OuIoxsTKw5OOlb/i45EliRt81KIIdMo2IY/fqE1VDGu
	5Y0KGrcWd7YsUKmUSw0l1vspH6WtaI1/QJ4R8VGzHH1pdu8hgULgOmpr9ZZL/TYkGWfTuw=
X-Received: by 2002:a17:90b:4d09:b0:353:e91:9b38 with SMTP id
 98e67ed59e1d1-3543b3bac1fmr11445640a91.34.1770049189348; Mon, 02 Feb 2026
 08:19:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260129225132.420484-2-paul@paul-moore.com> <38c9c9bf-3912-4e16-b15e-60890390e8dc@lucifer.local>
In-Reply-To: <38c9c9bf-3912-4e16-b15e-60890390e8dc@lucifer.local>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 2 Feb 2026 11:19:36 -0500
X-Gm-Features: AZwV_QhMxqLc50o5N0wo_jmaZh5-65SXwNGUuFUe1GvxMvLW0htJwjrZAphLdnQ
Message-ID: <CAHC9VhTouFsjWA9QeB81HEQEQRWGfyH9iCo9xZ+NyMTbZ5BpQQ@mail.gmail.com>
Subject: Re: [PATCH] lsm: preserve /proc/sys/vm/mmap_min_addr when !CONFIG_SECURITY
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: linux-security-module@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 2, 2026 at 5:53=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
> On Thu, Jan 29, 2026 at 05:51:33PM -0500, Paul Moore wrote:
> > While reworking the LSM initialization code the
> > /proc/sys/vm/mmap_min_addr handler was inadvertently caught up in the
> > change and the procfs entry wasn't setup when CONFIG_SECURITY was not
> > selected at kernel build time.  This patch restores the previous behavi=
or
> > and ensures that the procfs entry is setup regardless of the
> > CONFIG_SECURITY state.
> >
> > Future work will improve upon this, likely by moving the procfs handler
> > into the mm subsystem, but this patch should resolve the immediate
> > regression.
> >
> > Fixes: 4ab5efcc2829 ("lsm: consolidate all of the LSM framework initcal=
ls")
> > Reported-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
>
> (Sorry was at fosdem from fri)
>
> LGTM and tested locally confirming it works, thanks so much for the quick
> turnaround! Feel free to add:
>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Tested-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>
> Cheers, Lorenzo

Thanks, for the original report, testing, and extra set of eyes! added
and updated lsm/stable-6.19, I'll be sending this to Linus shortly.

--=20
paul-moore.com
