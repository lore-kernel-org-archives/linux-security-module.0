Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA15383330
	for <linux-security-module@vger.kernel.org>; Tue,  9 Jun 2026 15:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781018137; cv=pass; b=TxvdN/8BK32+H35XTgBOCYRKQbHACobVYr+ZADAb78L48mOhGU71TT5ONXFuzbtBhRRGvRT43r3lEnzUBXdW+SoOo9n2prwTZ7R9o/zcL+HdKckKwp5G7JURtfdWgEqrXUXTWCv0IVVgtVNVYqpk/hhhmrbGULpyc22vxdIpl+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781018137; c=relaxed/simple;
	bh=f1j7iu+o5kZq++XxgNCC2TIdJygR3iwb7JsnnVDK8I8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a/Cm7pGMyu9hUJcJ4HUiWaoHMGjBtuTYf2REEATDtUrgTT4Vi/mILeDylExO3MfbgtU9by32rmiDf5zQJR9Uw57p0vUqSSJ8Quo+ZYJXc9FZYoVd/hXkkwCIxppDBifo5UftVbe/GleaquPcdtH5AuYC4rCiBpRI7s72bhL/8vY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ROnEOxsA; arc=pass smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ROnEOxsA"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-bf046d4da1fso591152966b.3
        for <linux-security-module@vger.kernel.org>; Tue, 09 Jun 2026 08:15:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781018133; cv=none;
        d=google.com; s=arc-20240605;
        b=L5KSQVzxlreh99rE89pw5zpVz74XB5NLIuFtmLDkNg3M9Ehv1qjRF51LAtoXvMOhcJ
         0+Pcoo2Q2Vl1Q5iHZ5aeLnbq3reIV3VQNc8SkpnquzJgAIQhti8Fti/h0tcx2NkRQ9fK
         DFWIS5QCwce1nwExT1z3DPS8t42QNwo0C0p14VKU/3IsxUGqV+hWmdHE/h2m4H8vBwrJ
         i89OnHvIejbmIXyC7UO6T9wg4UnaZx66ralMq36uq94Dc5x+o2dk+c0/CAthekHdBGK2
         9boL3wGlK6hNqx76lauU45IFd9xOSRzZNgol36oUkpmeiMfpcYcDSkX/a947jsm8B4dN
         BZ0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=f1j7iu+o5kZq++XxgNCC2TIdJygR3iwb7JsnnVDK8I8=;
        fh=79mm5uU1MTvZc1v7yng4EpEPsRuE1nGrbEo1xiSXkx4=;
        b=GbHDJo0OMu9uUSboIlwxAgulqmjSPN9TWwax3cLF6GFJhHBVQeCouawbptAyVCj7ne
         Roz/7brykHdwlzqVkd68/yoVbWI1p74UJzUAgPUBu6pYjEi30vH/OEBnKPbu5X9xU0d2
         GRDWmHy7hKyMrKcTaltjBDWomSNr3EItVpUXTtS9Xn6wsCrngJphijVNClB9wqun/x8w
         ingPCv+fbNf2aqO0ZW1MJ6raoWcbShXnJBRhGeN4AjyFfHb3EH36eXxa8jgYxNbL6l9D
         tVlD2Q5DpMfuMz5ZSdZqmUyLV4esAoREzV6DwhYRbz9dYbYSvzmmc3ow3GF8zATOnTJD
         B+Tg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781018133; x=1781622933; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=f1j7iu+o5kZq++XxgNCC2TIdJygR3iwb7JsnnVDK8I8=;
        b=ROnEOxsALENQKer6pwqR5Pi6AY9FW5mhmD391bWe1k2/P6FM5CuCm7YpSruXaPsXYa
         SVXNw/hEYfn4HrViA8JArFyCEknOBOCpklb99bXJFU7P7vWwkt3+XwrqQv31GxhBW66b
         LIVPBY1fkuqmrGiwnpOrE9BwboM2S2YV+B1DZsEMbH/N5LeJ+ZTJV7bDcv7j1SSUAPQv
         Adix8/UdZ8xIzRiH3FeB2Tuo5Ak968lw9ZSAmYyivOUcM9jgjx2vj5Lu3Kl6w2jyYSae
         zjKO/2qUkX0A8qesAcj9Tmf7zisyW07svGgP/zbGChhxc0PgrvrgDMXIhg8Eqbd4d+jX
         xMqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781018133; x=1781622933;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f1j7iu+o5kZq++XxgNCC2TIdJygR3iwb7JsnnVDK8I8=;
        b=qkdHhoLBLzqW5lrK4cLOPJTU46C0hJLLDv3ocv5Y0HGLtmE+AtsSZLrpOZXbB6u75n
         NkMuUAcIrANsD+/oUs2Y/apsb0MiJyH9l/pmvLVB7Ke7gh4M6SJNL4ZVzC9Q9SiijO62
         7svQPFqgtd0qAdzDYlJEyMqim24jvFUaCZVVBvSqyV0hrAqnffaPHiO7WlacacbZUGb9
         okT/zUvMLBYtMiAwJUisqAF3DGDc94W29asQucwSujIMHeF3cqQr1XzxbEbPQDwfkBCk
         zJCpRKTw0HnhMxdoQhaixEc+ZpPqjIppoKz5lVP2g58nQ7r5LUYBSYozp4vmCxcWvlTf
         2YTA==
X-Forwarded-Encrypted: i=1; AFNElJ9gB7YAJTEkGEpCXSC1zy7o+MzEH5/XEn4nVSFNTxyvkTmjeVeE7qfCCAOGJ7wAYOnJtFQai3Q3wBKAlw7WYEHOVOCPN/c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2InNXKsDI8DY4HlLH1vCXxfVyLo8WWpvYVEljmfJ9ReYjEDIy
	yptatPeMMD54dY8Sx3jd+3rxEtLvtCn5sW6HQ82YzGpJZ4D332BQirYCpZOOH26zzdY6wkeS4Hk
	avP1JnNOK2uhPHajDbWHQ3GF2reK0NA==
X-Gm-Gg: Acq92OEdrXHuvgprbMABlKVPSN7kqMYVEd1bzF3j9ATkk5MQaycqanHU7VvMkwfkW2H
	WpjNiciImkheVDhmA34GwPV4f+VGKX/UBCQXlfNu3POJe3IdNmyLpd6fQMjhfqPppFNK9sqhNU6
	WfbQcywskSotBzGVwVJ55TToDC/Q8w9p7bbxHGazkZBm5JefHsoB1lF5wwwSlIB++3LkYt6DlZn
	wLwDmN3m1d0V30ZIg1xUSwS2dxh0Tu9g3AIPO/vXLP5GKAC/ApfPQ+PXsFeA6qbGG0TEtl9VhO8
	/TphChu+qJGYJuzq6zCSbdu5VDJml74Jar5FrPxMtfe9CHXdho8fZSYQYYQoHoukqyCzDU79Sy9
	fLwFK66PdTYoGoivuoF/kwchoLr1X
X-Received: by 2002:a17:907:2712:b0:bec:5865:6c63 with SMTP id
 a640c23a62f3a-bf37234ab8dmr718710066b.26.1781018132938; Tue, 09 Jun 2026
 08:15:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260604125034.13757-1-med08elkadiri@gmail.com>
 <aiZDlSTqaQTcvLBl@kernel.org> <85a686a6-7fcc-4a1d-8574-0fc7c2f84bc8@kernel.org>
 <aigoZeoqygyBYCbR@kernel.org>
In-Reply-To: <aigoZeoqygyBYCbR@kernel.org>
From: Mohammed EL Kadiri <med08elkadiri@gmail.com>
Date: Tue, 9 Jun 2026 16:15:18 +0100
X-Gm-Features: AVVi8Cd53HY8Byh_1TfSIUUalquq_E9RxBK_dmxQm119rFisNv4Tp0HsicGdC1I
Message-ID: <CAAMeuQTue5bkbhjYLjsRCnB9=KBifsPNQ=ZRVp+wCh2TiXE7Uw@mail.gmail.com>
Subject: Re: [PATCH] keys: prevent slab cache merging for key_jar
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>, David Howells <dhowells@redhat.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E . Hallyn" <serge@hallyn.com>, Kees Cook <kees@kernel.org>, Vlastimil Babka <vbabka@suse.cz>, 
	keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Jarkko, Vlastimil,

I will send a v2 this evening with the commit message reworked. I will
remove CVE references and frame it as hardening rather than an active
vulnerability. I'll also drop the inaccurate skbuff_head_cache
comparison that Vlastimil flagged.

No need to strip it yourself, I'll have it out today.

Thanks,
Mohammed
