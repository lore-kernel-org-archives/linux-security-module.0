Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9743A51C32
	for <linux-security-module@vger.kernel.org>; Tue, 23 Jan 2024 06:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705990647; cv=none; b=CY8MyohKGA0EbQsgAI+rPwHxo0JewbeMqVqgjh2UUD0WDtJiaft6tyjxiv4WqErA9HuvACSeP3leuX0u5IpRgw8qX7vmBhsU+/y36In4ifKE06f9X7q/KinoD1JmV5g1DqKURWikzuWx1g3UvzLhAPAB1tzzGRYFmoO826BpFjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705990647; c=relaxed/simple;
	bh=zyiBIARi2gCAD88pf7LI0gLxnA/Auw7ibrs2/QGivLs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QbkYEsc0LpOIKr22PSLgaYUnA66NChLk6/zkc0xDyaDgvS2x707imH78Q8Uop2vFpwWFpXPUePwosGhrPCGM0dVK6fUHW/3NKZInuTfm4gUKoxgQtUDUunXtBmiXKuh2l/Mz+/VuKEqHVYW5uKY9lfnI9JyQ1WORVKxYJitghEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fUCNlY8p; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fUCNlY8p"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2cdeb808f28so38130601fa.1
        for <linux-security-module@vger.kernel.org>; Mon, 22 Jan 2024 22:17:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705990643; x=1706595443; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zyiBIARi2gCAD88pf7LI0gLxnA/Auw7ibrs2/QGivLs=;
        b=fUCNlY8pl5j3AE3+LM5LHvYy/m238Xt4aoTFaPttg1gWu+rvF/b/2FRevWUUW2TeLB
         /KHywthbQHi3Lmm6ae7XIiyDGrm6PXWqUep/QVvCK8w9VZR0eGSRzuaehVjWCuMLjO1g
         3z51SDJCiOLiWqTKV4Y3sNlpGT0ofGeSYz043SfYt3/vbGsDpUexhARFJVH9Kn3ZGoAp
         9pZ1Bv5sEKy3S8+GcSfLHqmxTYWojNio9lj9kfqh1s4uCrYIc/ng/gi8Mlp9TH2jfk2p
         qJf+xKgHMI/ViiZ98bvUJD2WC/bvieyGNxFGowciVxwguiQnYXILkL1jFXtqX+wOuRIy
         3JRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705990643; x=1706595443;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zyiBIARi2gCAD88pf7LI0gLxnA/Auw7ibrs2/QGivLs=;
        b=pZPFG1X6Sjlfc58/qW9X3YY6J1HRoNJK//K1zBuIe1LdML08k120FcdVgxkAEw4+5o
         +rRbvBikNvrJDTQlfwA57MTxPz/MNbKERmSsJxeffJdXnpDbLTvvb1vZaENFPpj/Teyi
         S1bbgFCI0lNRbD9L+ikiIzxItvD768yuPjQxNdWMeraptTD+mDeyer12pPEkzgdUrn/O
         QEHAkQ6HmZjhpewAGsJlnTxqcILjlCS02gjMG31WrUKtYw8wbCAOYg80LmiduNORkAMK
         uzZHJAXzH09un4ebHM8eFgla3ksaV1zWFBp+CyfsL3RilsdrX/gU50jPn5XU/5HROmbu
         n2rw==
X-Gm-Message-State: AOJu0YzCHdE8Hu/IVsTsglK+MUDv22g3KyL5vW20HqhLsv1KKRxqWTeK
	GfzAs7Sn2lDvAkvsKNBv5BTLvXIsDEvh+PthkAo1fkkDmkV43UhiYjKd1Jrf17yxPSvBn16BQzP
	V22MG1k3Ds5a+VyVEjZ1yoN5MK4J5FO8ZW/4=
X-Google-Smtp-Source: AGHT+IHZbUYq5QBxBHBz4DwOzI7V16ATmmA8XyYoc0dqQXnXLXIM4iqegvEYh1nysac8tlMwkZnbgX0FvbxY9bBbv8Q=
X-Received: by 2002:a05:651c:152:b0:2cd:191a:c1bf with SMTP id
 c18-20020a05651c015200b002cd191ac1bfmr3956083ljd.14.1705990643288; Mon, 22
 Jan 2024 22:17:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230902004841.614102-1-shaw.leon@gmail.com> <0e81fdc2-9c4b-4147-91cd-22fa263b0a3b@canonical.com>
In-Reply-To: <0e81fdc2-9c4b-4147-91cd-22fa263b0a3b@canonical.com>
From: Xiao Liang <shaw.leon@gmail.com>
Date: Tue, 23 Jan 2024 14:16:44 +0800
Message-ID: <CABAhCOQDQV_LHXv5-aosJu9+sP6wE9kDgYB8n-hYB=XKS0B_fg@mail.gmail.com>
Subject: Re: [PATCH] apparmor: Fix null pointer deref when receiving skb
 during sock creation
To: John Johansen <john.johansen@canonical.com>
Cc: linux-security-module@vger.kernel.org, Matthew Garrett <mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 16, 2023 at 11:36=E2=80=AFAM John Johansen
<john.johansen@canonical.com> wrote:
>
> On 9/1/23 17:48, Xiao Liang wrote:
> > The panic below is observed when receiving ICMP packets with secmark se=
t
> > while an ICMP raw socket is being created. SK_CTX(sk)->label is updated
> > in apparmor_socket_post_create(), but the packet is delivered to the
> > socket before that, causing the null pointer dereference.
> > Drop the packet if label context is not set.
>
> not sure how I dropped this one, thanks for the patch. I have pulled it i=
nto the apparmor tree
>

I haven't seen this patch in the tree yet. May I know the status?
