Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794279752;
	b=yhJklAOQGbl18NnkHUbxyvo5TVM24Jn9Q3Q1ySfJM61oXvgqXkHK8miWoggxagM4lhRf
	 IJlBuhNf1RixDcG3xpGbtRpBOhNFxJycAZrV3iGKcgU7/FPaXRu7f9h+HhWM/9+b09PTo
	 EQopdYClCk75SSiv3nXOBer8kcwprIojsQl9RbIq7X1/jKJcje/JBHMCkvfXLLEWnPxRD
	 n3eVmPQgC6THNs2wJjHhLoftEacrXiiV5XnYwtRGTdsXbmGdCLKs44chi4tTEHGbXSX0g
	 +0JUHN6xSB781ccbJHp/BxOpP9acxV8zcTuUwXn6ZsgmkySFP1pv070TWRHM6GEsWfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794279752;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=MMWgpEtU/gtg2eO84Q3N861jXy5hniFgHLN4W28H+nM=;
	b=scl1b2n1ynMU4Wn8cdF+fh6sbID+KrPCoE3aLVPV9BeVMutSB0UZnQmbqB9vuNdHydfX
	 bJdt+z4bkNA1M7tb11+BUDHoMhpUj/vLz0xNGOdPm5uj1vOYpgG9JQslbsjbnnRT/isLV
	 0S2HxdusvKzyJNZ6+V+LSb3dn3Waa75MipByEAatfsvANTM0SaFv4wPsS0ifE+Fl/x9ql
	 RV2J/qt8CwdFCHOho1HfEtVBb6RUGaqwSBUYQTGUSwmqzU4CMzGeKQwnE6LYgS6kPwSDL
	 2VeBiDydnwn9OmmuQnNdhmumukiJIIIvvdhGiUiIqHcGmkuKdqvmUwASUyMiTLcPtsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=m6AHZfyw;
	arc=none smtp.remote-ip=209.85.210.173
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E61F606A325
	for <linux-security-module@vger.kernel.org>; Tue, 10 Nov 2026 03:02:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E61F606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=m6AHZfyw
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8a070781f63so673077b3a.1
        for <linux-security-module@vger.kernel.org>; Mon, 09 Nov 2026 19:02:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794279752; x=1794884552; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MMWgpEtU/gtg2eO84Q3N861jXy5hniFgHLN4W28H+nM=;
        b=m6AHZfywnNj4tR4b0GSl9VsmXD/S9+IKtsaMttHTfmvLEyuNPBVaeyrC6lZybk4qL8
         AqMx4gh9QY3A2GXi3T3Sl1KNT/PYRt4E28B4bMgBHPvpE7qHNa9zjSUQsa8agsfCwv70
         rg3VXJLclS4/RPoqCvxawkhdJhW4+YtVb8a3tCocYcSgyb58EDQwb/CRyXhtZ7YHu50U
         ILsbhkOeFxUCYUnyY50nyNPkbmiub34akV5jNBJl99EPlJFmrpITtmnkiFhkoYI4kYmZ
         2yxpPHcz4RDp1ojO4rhUmZwwxUiuDbnGIAjqY3xeCnND7EsZ6c0yZI8Lm8NN6TZEN35O
         Ihyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794279752; x=1794884552;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MMWgpEtU/gtg2eO84Q3N861jXy5hniFgHLN4W28H+nM=;
        b=FOKsA4rFZTr7pMybPH2rn9K2AcT26tm0qSrbBBA0WkhDSgOVXP7YHOhGNShE97+U6k
         xmefaDTW4afFBy8wNYe1PmhPJVeFrFezKKJjg6WULmFlc1jP+Ja3dhrrFtR9ipUNMJfK
         T495kIro2+hQXcOg/pv/EWuKvCkTBJHaainq233uTtt1Hwbva28OFqolPGzH1qiNVa0Z
         l4G5eR5brWIB7wseWbovNstvyJkL3hTSoyiJhZp2NeJfk5KRlFwltdW/RIJTJgpZNWi2
         iiE1SByo50pL6bhrY3EZaor30bVVOtrF3ZNxs3kUQ1MEWtWhN6KWEbrtReOtFvAKq4oA
         B0fw==
X-Forwarded-Encrypted: i=1; AL+hErHDUb/yE3SD2/DB/aBahNfRyz6pFnMgwHg6RaeMCMldZBWwW8YCECAemQo7BqRoQxKK/zZQHPsAWTU0D9ExQaigvhG8uyU=@vger.kernel.org
X-Gm-Message-State: APuU4Z8aSFGt3kVENxVT2gQ2NWUPETawRfzBSbCsK/7UW1WpB7sRaRe6
	UP2XOq2KKTN1O6agYbVnNYD1V/GH6hhBOrGJVEykBOWx7MMl8/TBfTiX
X-Gm-Gg: AYBFou2wXj+1AIjDvqUgbx2WMhWCQ/jbmy1k3CDsV4v8L6mWDWN0hqMpvDxJUvdOlSq
	fzhQlqAWWnX3y56mFyS2NkMZZQDH+jgnkgfozc9igDRvTCNWliwqPH6JOfuZu4hvVsycHyQhKxy
	4zF4QJBw2A35sIMYGko+ajHGd7qrRfULL8h6n8Hlo/2AsW9nmRqaUxBRTkTH421zv+3MiX7EYa2
	1tbS+Vx37x99qpr+EiSXeLy0vYqcnfPc2R2/Kq2lWMY0lY/8zdqdMiatHIJgIK6iEi4Z7dpsNvY
	MyTm7DaBk08QSdzAFr9GDW2d0LmVhL1QtMni5GZtQXf/TzKCcLQRIBgABJA2D6UsfpNnoe5GM+a
	lHA+MpKJu7FrACIv14g7QDpN2mTIN9/Rzw4dxZV+oIcIxGb6MOMUh8aaruJ06csOE5UdXfp0DRP
	eIF0/JmhQ12kCGjJu8liQ/jfnTAsj/b1BNL99B5igC4Ib6vLJbBUa/yP4YWUBDQA/LkGdS7MTbY
	sBX/7AMUGe7SJ0/7hlNZJq0UC5sY4dSrwJ6Pg465tB/5CKYt8868iekbmRIT4BYh0vCVgLAkh2R
	jHxW1UomC1jXXCX5S1Rvy2ulA9Fgmp4yT3u8
X-Received: by 2002:a05:6a00:1887:b0:883:54dc:7892 with SMTP id d2e1a72fcca58-8ba876454bfmr1402875b3a.52.1794279751668;
        Mon, 09 Nov 2026 19:02:31 -0800 (PST)
Received: from ubuntu24.localdomain ([124.77.124.144])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8baab9d572fsm317021b3a.56.2026.11.09.19.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 19:02:31 -0800 (PST)
From: Yuansheng Yang <0xbeac@gmail.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: dhowells@redhat.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v6] KEYS: Protect pkey method checks against type removal
Date: Tue, 10 Nov 2026 11:02:26 +0800
Message-ID: <20261110030226.9898-1-0xbeac@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <avJ4KM-Erci0FkgZ@kernel.org>
References: <avCZIMCsZ4um18e-@kernel.org> <20261109055204.31673-1-0xbeac@gmail.com> <avJ4KM-Erci0FkgZ@kernel.org>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit

On Tue, Nov 10, 2026 at 03:49:28AM +0200, Jarkko Sakkinen wrote:
> > -	if (!params->key->type->asym_query)
> > -		return -EOPNOTSUPP;
> > -
>
> I think I asked to remove this. I need to revoke my reviewed-by from
> this version.
>
> It's not relevant for the bug fix.

You did, in the v4 review, and v6 dropped the check again by mistake.
v7 restores it: keyctl_pkey_params_get() is identical to 7.4-rc1 again,
and the diff does not touch it at all.

The two early checks in keyctl_pkey_e_d_s() and keyctl_pkey_verify()
stay where v6 moved them, in the key->sem section of
keyctl_pkey_params_get_2() and after the buffer size validation, so the
error precedence is unchanged.  Only the check you named is restored.

Sashiko's remaining point on v5 was that this check reads key->type
without key->sem.  That is how 7.4-rc1 has it and you asked to keep the
hunk out of the patch, so v7 leaves it alone; the call sites recheck
the method under key->sem before they use it.

> Also if possible try to make a bit more compact description of the
> fix. I did not ask this for reviewed patch because did not see it
> relevant enough but now that this needs a new round, you could
> address this part too.

Done: the race diagram and the paragraph describing the early-check
move are gone; the problem, the action, why it is safe and the coverage
list stay.

v7 follows right after this mail.

Thanks,
Yuansheng Yang
