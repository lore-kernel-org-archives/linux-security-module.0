Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795815676;
	b=aytT+8Dz9VnBpuQexbrg359PZ/ovlb4aGnfVk6JejGRGTTw031a7ytgaEnnW+0RZMPGQ
	 fXJQUIRJFjy62NgICeog5OqQvri/15JIaRAmhUjmKZuFJ/YjXtozI4wEh9RuEAIXQAK8K
	 NBsHranF0xegDQdTUk/LnlbdH9Tk1EKRPorO2bYC3vRuaxvuFa5j3QFlnVDePj8YN3G2n
	 Tl5XJJg1jjQj6F+xa9wVfnsK9Y6QOisuvjCsrp7Fus7HXlPmXfDMjSFC+D4e6cYGjpOR7
	 FybQuL9xd7+SHsJjIz9wXxIzs2YxE2IxxE9zOP1pUkmy86ma4e4SmAnjFMjVreGoTsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795815676;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=GNjJtSmgBzeJqa75AyMuB1FfpMIGeExfgQrDDeRI15s=;
	b=osraNvryI6+t1RvpdEKQFjkjjrh9F4fLir21S65e1ykiDhOok/z7Wd5ltXuTdRmgu4/G
	 mM6t4JUkms8JMBOfrThbHyBOaFWRNjrwfq7ogA4a6DTlUIZZ1uksJbMH6Y2tPQI9lRxo5
	 1vHZNZ7gLjmI4ZM/L1eXR2gUrp4pqHPDiR6eW7wclXGiggNaLGpO8MKMD8tQ3iK1taO4N
	 FDdl/k5oohlH3RnKUdazFGDWZPBqgUNrVnx25uwLYg23BV1D9ZwRkQfR5QK5kWrkDHVHT
	 0uTaGLm7uDf1eiUWIszifWaG4hnjCK2IL0KTvLDm3gFF3ucqck0X5JCZsE9Z9vdg56w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rlJzjc+L;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418AF606A324
	for <linux-security-module@vger.kernel.org>; Fri, 27 Nov 2026 21:41:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 418AF606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rlJzjc+L
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4bb77a462c6so68496525e9.1
        for <linux-security-module@vger.kernel.org>; Fri, 27 Nov 2026 13:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795815674; x=1796420474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GNjJtSmgBzeJqa75AyMuB1FfpMIGeExfgQrDDeRI15s=;
        b=rlJzjc+LyIk9Bk0QS6P/I8TDEexyuBC3YqrMNuS8l9ecZxXqzecIXHrsa2+jjLCIkd
         AvdgA+lDcovhfWDGGXxDDTraLo/z7WixYN6CS0WFtDPjvWLKrdb2LmuL8SVsyVcmcUAE
         w7uKvqNGQ6fgCtW1/YqXftDsvKWqzLc/etNTUBIImSolgJ458EFpxfvonhxlMSH2he0w
         gpZYXR2cdjzW3qoLBTUFALao2MhHDceARIdwR8T5fNHKRhO5CZKehhou/RRtD33QzCTW
         J9VxQgQTSkBjmppRZyAfVgxgVnOD9jDbF3HW5K6gfIlLPnr/76nWxRQFxdk3GCbefAfK
         3+gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795815674; x=1796420474;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GNjJtSmgBzeJqa75AyMuB1FfpMIGeExfgQrDDeRI15s=;
        b=Ga1m8nG/aBjTX7aS07KrsuoBBSavCNSEF+gJlKL/W1ajnEMgQZlc0TDYsyveJIma7Z
         jIH2lUzTelzxYWTo39Hch51mZWND+rBcQhUCJWtowD5azrsW4OVmjZavdBT5NGxIz1U5
         LrMjvaItX2Y+ESF/hDLjC9+wuh/0ztHEjB/oWSCuMzObTW8oXvjutnKiUtR91nWeETnn
         nYjBIB8B27wWALyanFZQX0FmZyDcFTPqlBX/fP3aW7IFNZ+jSyu5eOF0enEM/X4O2YJS
         sAKpPFxmnXEl2CETTuvltgoV6RbYLnOb1rX3Qr+P7yeNi9QinsefwBl/bJ+TvhmyMeHQ
         +U1A==
X-Forwarded-Encrypted: i=1; AL+hErFnDGsSf3EpJ2+zp8OYRaPXerZD9Gxg9YNO86oDh0T2+3TCBdTqIaLB5hX9jjKq+9+AAtraS4lmvF/unHqzeWAnvo6pM60=@vger.kernel.org
X-Gm-Message-State: APuU4Z/4SMUMSkUsOezhUesstQ9TZz+y73cfDELEFxBEZW/0ui+qLU8f
	9zDnOGr1+6xSyCakydNJu9pwkRdFayUzgVgfhWTmXiUu1Zf382KtZ0kp
X-Gm-Gg: AZFdTZfR2DLR+EB8E71XIE6w1E+3OZxSXLvREgHlhUeavIp2QrNsHDM+MyOOoB8RgIc
	EbF93KsTVMKrfM4W/73rJeaATieyQZuBof1nehs/UEnfaYbn86Q/8UJ/PdO/kbln6TfCRs9Nxva
	WSg1yl81iIABWJyooofYGuH4dFYKjntAunZvHoBj2PO6uAOReXqiEPrubWDK9M9X0/dSgLGZykR
	3Yi1IfGSkITIMm503bSFXr8UVtNdpnnLvNI1JNnDIOpvgQ7/McYiW2NCgVd6W2VnHaPNGuj8Pz4
	L69u0fdN3SeIMB5a9q142sENL0gkktEnsqNzx0gWip0ScpKJKMCvcPoThIuka4oQKa+guq6qaOY
	yDItiVv9g33EuVIJv+YzB2/QC3Cb+iIRx/e3ss/DF/p6NpXtEK4tnDbgjDqlUR9fPJknhxl49uM
	4olo6AzjU5omB4VSOgYzGSMlEKNqWJuYkbitu0hp8ekK6nCx8o5XALXzD3d3y1ytbvHC5ttT5Nb
	O1YGPJ+i6TET75d0vF+ekomzqgtl6Os6bA3xZBji8D2fTnHceHFIx8UTvNFlFQeyDNBhKol+HYp
	L3oDxNvr+KV3bvTFjxVb8qF9pA==
X-Received: by 2002:a05:600c:a085:b0:4bb:85d9:156e with SMTP id 5b1f17b1804b1-4bb8880fe46mr518939935e9.11.1795815674386;
        Fri, 27 Nov 2026 13:41:14 -0800 (PST)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4bbb97e5356sm37714445e9.4.2026.11.27.13.41.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Nov 2026 13:41:13 -0800 (PST)
From: Askar Safin <safinaskar@gmail.com>
To: jarkko@kernel.org
Cc: aleksa@amutable.com,
	alex@amutable.com,
	alexei.starovoitov@gmail.com,
	arnd@arndb.de,
	bpf@vger.kernel.org,
	brauner@kernel.org,
	containers@lists.linux.dev,
	corbet@lwn.net,
	dhowells@redhat.com,
	ebiggers@kernel.org,
	giuseppe@scrivano.org,
	hughd@google.com,
	jack@suse.cz,
	jlayton@kernel.org,
	josef@toxicpanda.com,
	kees@kernel.org,
	kpsingh@kernel.org,
	lennart@poettering.net,
	linux-api@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	linux-security-module@vger.kernel.org,
	luto@amacapital.net,
	neal@gompa.dev,
	oleg@redhat.com,
	paul@paul-moore.com,
	ptikhomirov@virtuozzo.com,
	sergeh@kernel.org,
	skhan@linuxfoundation.org,
	viro@zeniv.linux.org.uk,
	zygmunt.krynicki@canonical.com
Subject: Re: [RFC PATCH v7 00/26] userland: Userland containers
Date: Sat, 28 Nov 2026 00:41:03 +0300
Message-ID: <20261127214103.542291-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <awOQDOel_72Xwjm7@kernel.org>
References: <awOQDOel_72Xwjm7@kernel.org>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Jarkko Sakkinen <jarkko@kernel.org>:
> I personally think that "getting in" should not be a goal in the first
> place. I care more about that whaever gets in has a high bar of
> quality enough. It can be something different than this but
> when I read the LWN article about Cells I was alarmed enough
> so that I had to do this and prove my point.

I think that Bacik's patchset has better chances than yours.
I think so, because (as Bacik said) it was tested in Anthropic, and also
because Brauner reacted positively:
https://lore.kernel.org/all/20261021-zeitig-niemals-clubmitglieder-b3973fcebd38@brauner/ .

So I suggest reading Bacik's patchset and say what you don't like about it.
You will have chance to influence Bacik's proposal before it will be merged.

(Note: I am not kernel developer.)

-- 
Askar Safin
