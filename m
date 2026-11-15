Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794767296;
	b=ceJE47VFH73O6XDUhAjwPxEzCpQAVKlsRl6Haz8DCz2mWHASQ21O+tHimnrgOLURt7Gh
	 EJzvvoVsWwISixYq61aFW6kwwQcZLx9khM7FAspFJVJGhSSPuvd45VQ3M4BdvFm5X/lPv
	 kT5EnKFHTka+d5krbnWKu3K2vqn3QeJQmNSlztYS4AqZUy6B3HzRxMfKwqoA0pfHq3chL
	 MELAKR5uJtjZAeFJNEmIRiRWbmIClWKui3L9X0cLT/4DVe4yjZ2be1LS33ZqbFkBV3Rgn
	 bM2aeeuD+Eclndv08QX0xxDWrhMhCxe79j0t9QWF+9gJ/8EvGgkzNprZCdrlloc6haQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794767296;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:To:Cc:Subject:From:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=S2sqyuT4GDnGp9+dHpDjnGTvZCe15TFZq/xtAkotKkE=;
	b=23tu5QJZ1Ew8zz9Tvz7PSRw/t0/0cJjyW0IBEUWI+sj6Mp3hrZ7w7W7HMb+OTD243gvI
	 OdMaHB8/QD6Ov3O8KY0qcVTl4LYFBnWOVJZC73RRB4lZGsEuUbtGyePJJ3qXm0NKaq+H8
	 BmtHvXYTCoT0qG3NqS/c4vhrEhec2xR5868yK8+Jy3Dp6EbXvI0PJUrIxikagETUS3/UT
	 15KbGTljkyR/yxbBJeuMI6iwbMhaX3qr3Tr65W/7F1iFJX1KzzLCNsRnsYPDRIbIt0Xjp
	 IUJ+gEzP/UvPbRVHQg+8tdNjBiaTGqFVSwDD9UlMaDsRf1wJQAIO/adBR/rzZ/d/DkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HBV5nxYv;
	arc=none smtp.remote-ip=209.85.210.173
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5284E606A329
	for <linux-security-module@vger.kernel.org>; Sun, 15 Nov 2026 18:28:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5284E606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HBV5nxYv
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-886e61fa30fso1067779b3a.1
        for <linux-security-module@vger.kernel.org>; Sun, 15 Nov 2026 10:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794767296; x=1795372096; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=S2sqyuT4GDnGp9+dHpDjnGTvZCe15TFZq/xtAkotKkE=;
        b=HBV5nxYvdpLlRvsxsYLbFKr5P34f8mj9a/XJil7dVolrFQomVVkyecHxP6BgFGwDxs
         /19GzczoyqLC7fuxmwJyN2rwUymD2CerKLMnjfS/2CRMvt+ynLs5gkxwuVBuAu3q9J20
         IzB2wBplZLjMFwEGGW7prCWCSa7Aywa/5h22qXYWy2au5OKH6AKODohFFnhhSeGrFYHI
         n+FqPiDDYHHddi3JAW7aghC+X3tcMJhczYrIX5Hp62B1gpJjhhKWZLANouBkWkfFg5wA
         r6zaGmjBjVlFtwZxS8OaoxZbnmYU5uIROK1UqsDLBtdOM41dsZCnP9Jsrl/zETDD4H/q
         kP7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794767296; x=1795372096;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S2sqyuT4GDnGp9+dHpDjnGTvZCe15TFZq/xtAkotKkE=;
        b=gDJq8mOjS3MuKmvLbcYLcey4Bb5fH5t24PauKjbqtCh9okleBKM73o9U39M4xTShrT
         n1y7bNMF2+aR8cJT0b2TY6QRr+YuQrFOx2dIN+V/yHXnlg1NFpj9+8b0GKUk2jDiCX5P
         D2G4zJnbW+SRjBcIxPrLMTD5M3OYzae4Gz3VmyGqmeYCydOzvbnfHYKdHtKS7uaVA/A7
         W5fTDHwjC0JHPMuDsXn2U9ucZiSiBF1EW+ZhJUoa8Ted2PI6bAFbpp0QzMb4rC76fmSx
         5nQqTInwdw6uhvNuD38qCy4iNTbZl1/4HYmYpipFJ0Ecu54q8QknL2GHzRFhWp4Uxnly
         LWxw==
X-Forwarded-Encrypted: i=1; AL+hErGm9aO+9KLdhmRwHfDrtKeH1ICefxbqTQGdP0WNddq3AQH1+TBRhWfYigEosMYJ8OaNSoogrHHOJPSb9E09zT3DdEM6DsQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z+uGBYhUwJVG/rxGLedhO1AMP7nlERMg+IBSj0qpjM/5ZsutZ2U
	/WYFizhWtki1jTKYDUV4Lt01jHdXqv+t+5/RkOVsFBfCnLXDv5uko49r
X-Gm-Gg: AYBFou2p/JiT8jAjmc8hGIR0CAdFGdmfThzxGLGBJd6G7PpvjTjc1UKGqMVlnevch1J
	BVvSkoaKuPpF88F0Jvw/deK31SF9SUkOZ48KBFMbNN3u7svcHnINzOehEltvnwdOesNAJ4Vtav0
	kgrlulB+z0Lxh6L0NEUtRbz3mxeLXKUdH24JV4Q43wt1Z7YPyQr5W01p1oJpPB6UNeKvcva/ldz
	VoAM0t3A6KkeHW5lq11WyLuADoNTueoZ+ffd6lv/yd1p75J4WQWOSvLExxbwNKIoeQ44nwjFljY
	Jm228WcJlK5xqJcZP+ucxkj04W5PrzbhD65DiLcKcVFEb0Q0dVo4u81PLhTEkQj84d+R8zQL2mG
	4pToL84QaTyesJjS9jHzVj+oIqF5xmqTeVebf4iYKxFFTFYqHQw8OMiMVmkQMGYVgc9RqzBrzMs
	lR3ydaR3byh3lrwTO42Dgs5DKVbHPra9DqIr8p8Y9uGVTPGKJXhUzYsJl7D9wIipWbDp1Eg/U8n
	wewDky8SSHtY05FWia9A/FyMj47ORPttaP2KdJ9MsyhaDlTNHiktlf4tQuloo5wCoTZVeaGs2uH
	H1al/kaBi5Uwkz0D1VyLLhcgdx5FIbYHodBrNT/WG8SjT1rp66CrCUfSsmoXspsV6YTQZFBIzXo
	VQ9+mqdVCOL/D6W3cTcwJEgC9i3ihB0/d5g==
X-Received: by 2002:a05:6a00:230c:b0:89f:d620:226 with SMTP id d2e1a72fcca58-8beb619bec4mr7100607b3a.24.1794767295502;
        Sun, 15 Nov 2026 10:28:15 -0800 (PST)
Received: from localhost ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8bececcce6bsm2804318b3a.1.2026.11.15.10.28.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Nov 2026 10:28:14 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Sun, 15 Nov 2026 18:28:14 +0000
Message-Id: <DMVZWOMFDBX6.3HVETC9L8RUEU@gmail.com>
To: "Christian Brauner" <brauner@kernel.org>, "Amir Goldstein"
 <amir73il@gmail.com>, <linux-fsdevel@vger.kernel.org>
Cc: "Chris Down" <chris@chrisdown.name>, "Miklos Szeredi"
 <mszeredi@redhat.com>, <linux-unionfs@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
 <linux-trace-kernel@vger.kernel.org>, <linux-integrity@vger.kernel.org>,
 <linux-security-module@vger.kernel.org>, <linux-mm@kvack.org>,
 <stable@vger.kernel.org>, "Sashiko" <sashiko-bot@kernel.org>
Subject: Re: [PATCH 00/13] fs: let d_real() fail
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
In-Reply-To: <20261115-work-ovl-d_real-v1-0-ca155efbcb2e@kernel.org>
References: <20261115-work-ovl-d_real-v1-0-ca155efbcb2e@kernel.org>
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Sun, Nov 15, 2026 at 06:01 AM Christian Brauner <brauner@kernel.org> wrote:
> As Amir pointed out the correct fix is to teach the callers to deal with
> an error. So d_real() may now fail for D_REAL_DATA and all callers
> handle it: uprobes fail when they're created, IMA treats it like failing
> to hash the file, IPE denies and the bpf kfunc returns NULL. Then
> d_real_inode() goes away so nobody can ignore the error again. The first
> patch only drops the WARN.

For bpf bits:
Acked-by: Alexei Starovoitov <ast@kernel.org>
