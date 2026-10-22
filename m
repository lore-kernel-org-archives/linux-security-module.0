Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792699638;
	b=H37Rs2nj08/Es/jUSMumDs/8lGrsg21GTG04CizS/CdsPWYYkUYEf5jiQv4Hy4Kjv9bo
	 QUQTHcmUfFB4oxPCfaOFE9OtSTLruQVHl0znaQ8/YVSmNw/6apSq+Oo6Q8J/d+nmhz0vw
	 FJaIc5QLvTMqES397sJ/JqZAFakHI757S2AoUnaRJuGVuhTYhYwtoxnoyJwO7yYp6YqYO
	 nWjuYmHR0aNSwqUCUQc5QIC3sF4wqgde3h3Tw/GHZecjrpWB4MSu2USoUPIiF/Lbh9NGE
	 /NzS3w6muCbeIO0IFtsX2ei37MyI3DvRS/YxaxeT4WLdXn6yUh4yYYvbI7ytAbH+iuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792699638;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=5y0FbaF2YCk/BaY6II8Xmg/yMqVJ9gKVeaXT/rHnTY4=;
	b=uCRRELhsyYmf247E3J5sxh7IZdWWdspHedx0HYeOa+SGpmRq38omiErofhzEZKo6cif/
	 qCVyFORG7qjoIsWk2Azq2zoIJHqqHFJwPVR2JRFZv80B6lHksaSru1+nYCkeGe29ZS2sJ
	 NnSYKI2LyfzwXLCzC7U5JH5GIS6SBdMO/S8Hm41EjgWQeISIAbOkdOn36/n940Rzd7h/K
	 QcSK6NxhN3y13ZtIpXp+F6cNCBJYuUnzgmnbeSf7ToeRuYhm5PYsJtETwo1M/YJeMUUHu
	 nwW7lI95CdsyvpMrdc3IYEYssc9aMbeeLhYQ6XAX9YK3xwj3rcyP12gYA/am3j9nRuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-foundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=P8hQVzBM;
	arc=none smtp.remote-ip=209.85.208.51
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C25B606A31A
	for <linux-security-module@vger.kernel.org>; Thu, 22 Oct 2026 20:07:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C25B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=P8hQVzBM
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6afafc89b48so169042a12.2
        for <linux-security-module@vger.kernel.org>; Thu, 22 Oct 2026 13:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1792699636; x=1793304436; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5y0FbaF2YCk/BaY6II8Xmg/yMqVJ9gKVeaXT/rHnTY4=;
        b=P8hQVzBMfus53RAHLBkDlmsUhXw0HbFbfS/WU7tj4kTxXAwrj1icH4MttI0lB2rzoV
         loRo1MUQUPb/wepKq2KOG43mW+g8fZxlxht7B045hLO2UYCz+vu3uD/NV+nLgfpuRdBx
         y+BSpOUQRC45vWzCttTeAOTxAxNri6WONGUsA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792699636; x=1793304436;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5y0FbaF2YCk/BaY6II8Xmg/yMqVJ9gKVeaXT/rHnTY4=;
        b=HxzfcVI0b8R0eVeC6xFlw1EkraXVTZEMMMHdaSbtEUh56SOclgjWgdYQ8kR3c2hV2v
         2b3zk8BC0s1cnQIfMRv86GnN0hEpUmx7lITc3gkz7fN6iJecP3oeekC2UE/Vv9RebYCT
         yW7I1Fs4XlfEGrugpDeJ9vZp9LVp3KRiiG71zbDaxPEa96t8+pPz4/nhE85xKmIH7KvK
         yJmObwtFbxi3E7Q7iVpA0SOWBKyYGdUKi8OZ9KbhymjZ324ZT8sPkzP9jW7949yureAA
         0OkmBGxIeE4b8YLoInUO3dFu878sspQ1T9vXrx2ZoHPQWaMgSNuoyzscelfEbrrFI43l
         gH9Q==
X-Forwarded-Encrypted: i=1; AKwUvBx4cXUEBDOQ0UqlbvY6587WnxRmXeRKJmlq8ckFhhdRvhKy41ZMVPJbQEXmVwf41f/tO78LsS1S7JBRyyNVdlEmzZw3gXk=@vger.kernel.org
X-Gm-Message-State: AFq9FYL5gdk1IhesOSI30j3/QrlTDqSUal08A0COTzSscejfL3PjXwdy
	3lzYWuSReA4l+I2kbX/r3RXj1wDcntjvXaRo0UkeC9i7iI/OWbf685M6veGi7SXhcuAMA44/G/l
	Qg735UwU=
X-Gm-Gg: AYBFou0iAVX4y2+jGZbzmnsnl2+Pqab1oWK4me02l027X3paIqTROJoH338k+b4SV6n
	/SSvuuWKI6l3WHgEGh97iHVWPXphVASCANWqfLpIGUUMsC5WFpV0OnK6SRDlMoMVkYxrG1RDv5i
	AQjV1kzvNdbbJUJgmILRCvl8/KlQkI3xai7m0+mEpDikug9oAqcNlQR5Zm9jmzkXh6VC7b603YU
	PcUFHDh+hl7L+/6UC1/wjwNw5uCzSprB419ERee1K13mHxK2oO5Rg6TCjhFIgP2eT7/478Oa1YF
	QmGAwreI8zRJOsyOW38nbivUk19Pmu6MDqYqq7dvdi/d0v59Q+hdX24nEBeGFLlBZMqgHQ4z8eC
	nV/LIWrROauxvtLc1NX7hXqL80tQkzcZ/owTANQlC3RKbI9nsrhdzwfAbW21cVlv0Q1FGSMDK7K
	T/lVe1CNp5+9wsf6zYlzxicU65WWqetuQkqxW/qUwgYXdX3gUOjnYy9QyorHNAA6wv6599aZmAr
	3KkqHx8eUfGXiqbtqQl4Lax3nhrVamRZU6dxvWEdi+5+tv3Ff/iXOC6zHN6mCYfRvDHAEIO+BJw
	oMmawMNKIwgBs52gxkDUobvVs93lDg==
X-Received: by 2002:a17:907:9703:b0:c3e:cb50:b7cd with SMTP id a640c23a62f3a-c46a9423404mr32263266b.45.1792699635680;
        Thu, 22 Oct 2026 13:07:15 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46a5cf7164sm24025466b.76.2026.10.22.13.07.12
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Oct 2026 13:07:13 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6b1a86c0316so190351a12.0
        for <linux-security-module@vger.kernel.org>; Thu, 22 Oct 2026 13:07:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByf/6tSYCAAUUESQGF9DLqf2pe5jBSQ8LIa5C+pkeFDb9lfAKN+YlnVbBChaT8NnMKWFtChAlSwFCEAU46mfVeMSFa61fI=@vger.kernel.org
X-Received: by 2002:a17:906:dc93:b0:c42:a326:78a9 with SMTP id
 a640c23a62f3a-c46a940fb59mr32870866b.42.1792699632620; Thu, 22 Oct 2026
 13:07:12 -0700 (PDT)
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <atjKs7PTN8CgndJg@kernel.org>
In-Reply-To: <atjKs7PTN8CgndJg@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 22 Oct 2026 10:06:56 -1000
X-Gmail-Original-Message-ID: <CAHk-=wjouh66VCZjhUedb+wkRTWB0vsoDjU3N0huGsiYXQ5S0A@mail.gmail.com>
X-Gm-Features: AclHuK8nlFozT4sO2BQre7T2aT1PPMpnD_lYchNmr_bb0lScPlgwfBadd1Pr8mY
Message-ID: <CAHk-=wjouh66VCZjhUedb+wkRTWB0vsoDjU3N0huGsiYXQ5S0A@mail.gmail.com>
Subject: Re: [GIT PULL] KEYS: changes for v7.4-rc1
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: David Howells <dhowells@redhat.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Eric Biggers <ebiggers@kernel.org>, Kyle Zeng <kylebot@openai.com>, keyrings@vger.kernel.org, 
	linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 21 Oct 2026 at 04:22, Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
> A patch that Kyle Zeng submitted addresses a critical bug [..]

Note that breaking local KASLR is not a "critical bug". We just call
it "Thursday".

Breaking KASRL locally is trivial using just all the normal local CPU
timing attacks.

KASLR is there to make remote attacks harder.

               Linus
