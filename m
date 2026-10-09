Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF803DB300
	for <linux-security-module@vger.kernel.org>; Fri,  9 Oct 2026 08:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791535601; cv=none; b=NshG3eYnPdixlAHeuIeLHkVrBohpT3Y47Z70s9E6uNj1oNZjI9gDXDL7a0qxwC1vYs/98BKMntKNIuVAjsd7MW6pxcYBztYXpRWLDJ+ThWhyo4iQpvBL/Baxtaux2QzRmgKOoVbzzivj6Qzg1A7ccfR/S7GsDBkAtCwZ+KT6M/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791535601; c=relaxed/simple;
	bh=GByZ08qFPSVQ2Pp57befi5j5wUjE7SDpzVp306QsXF4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hdie6kq5aWL8ZImht+7kY7rJbltHljVwwRIJ4CzH4pjlMcRK2igECj2PpUOpeO2vDhVBgxqzrEG1a3qapkGI4MU2kcs4A/qxAprclGsqzupBAEShdS6J/c7hsUDoZ76k0qA23Xx4rmOfW7F+rf7gvIa63tCzI3BzSLgeA79M0bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smartx.com; spf=pass smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b=KT2Jf3VV; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smartx.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b="KT2Jf3VV"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-34c4a0868b6so5658659eec.0
        for <linux-security-module@vger.kernel.org>; Fri, 09 Oct 2026 01:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20251104.gappssmtp.com; s=20251104; t=1791535598; x=1792140398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nl6lGsMqVBD+W3REigF7CuZcaNchMe60i3xLXWgAPS0=;
        b=KT2Jf3VV+Ku2Lq7YfETGfHTywVv4kBVMSYilCVqRRqwm2hSXPXHoYEJ7DpC0bg77Ak
         9K8pNSyrGp1pWVxgsBZbItXnQlvKzrJCfXQMxiGplmWSUfajR4C321Uuy0wi8e3QYqJk
         BKs+rybuTjzp5WsKs/DqK4vqLnNBxjn2FE56zPIWtyZTgGf0kQ9+paKqTKzua7lwSdI5
         4SeZ0RI4ZSEl2C8D8wTygQQkAEfx4lkB2CpFK8+Cses6cJ5HKOfSdfzfvU6h3P1jNYQi
         sP7jL+Z6MQAdXT3LA9JLhXtWZivJrpggGFZymDHHeMOldq99ml5ryS++iOQEZWd4doR9
         ENIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791535598; x=1792140398;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nl6lGsMqVBD+W3REigF7CuZcaNchMe60i3xLXWgAPS0=;
        b=BGgXa1cO8oZKyz18Va5s+rUJlIMIcBs4wZQdpgNEr9bmkGQ9Vnwwrlwtvfcv43mwI6
         Wo/qot8Y1XtW0uWRAAH4+8AXUTbt47SK305DERteu6sffkp9xEHHfJKVMe9cq3kxX+cE
         h/lGiXuyVi0K1fULIZsVG77ItO8Skwt01a1uQ/H+w4gcLuGNI/u+2bB+rDe+D0M3DpQt
         kEPj51iithbJnu+xxWZFvki84cf2mv3FnjCExCJoydSkLi+Wr2hLEUMmvc+AsoYyX448
         A0WXYRWLHOTDxK4M/EjdSYketHe7/MZ+kvlQ8S1LoaGXgDRfgRvFeDuZdCDDR2B13l9z
         LdJg==
X-Forwarded-Encrypted: i=1; AKwUvByi/PHYZPQSbTrjj7ZMwYKOgk1qIyrwayUhDuxa3PKF3mkP+2Pr4jcwSSTkaIun4yPQ6DeXciqDfnoROHH6gpyb9m24/oI=@vger.kernel.org
X-Gm-Message-State: AFq9FYLI4IYpTwRW0a+/CWjYr+iQ4YKPQmpLkrxnRDPmtEwVzCcVX7XO
	6u/dUUGVySmAPH5r9y0q5thUZikYSzxgbw0D/A6v6VRlVIrG/s+ilzH9UoV9MlsOsNOomci+utB
	z332PdZNXKA1UY7VyPt1uph1hBA8N0CRGdmbF0YDlP6ASUBaVO5exT5PoZ/uyKEMb7Q0v7fw=
X-Gm-Gg: AYBFou18fcTnEj80txfbNV3bEx6nQLp1T5/Ck8QruSU0Co3Yf2Bq+vqjqm9aPQXJL42
	OGiCvni3vguEtBPrudHATeRTRfXMLEwd6NZf34IdmiEWmZiziwG9J5wLpJza9rXkHv7Qvi8n+g5
	JIWSLW6ci0M882YVGysfVvzAN28V086zWy01tkdAbEvilT5UVccA24irpc5hRbupj1Vpv7HAVxn
	QzEeOg/zplCw+NVfm6lCsFusHq0O9YdgF7RpyMihE/Jzw39PxtYt+0aqhK+Wx0Z6M4FUHJTNas9
	vXl8ssgs5x36xTaINfQ35Und6wSp3W7As+RgWPTucyMdI7MyJO4ROwQErMZ1c3U5S2kz8SWW10Y
	WMrGQYZp/vfi3FVEUr1vAmbDDTGFXEFbXpRJif3HHW8g2T87tseOZR9wrqjQ/VdFTyvAxAgTZdB
	9enXWZ6kQoIhHciYGPQMJgu2LmRHkYR4k50TC9uwRjrSk37RBDSL5jjKvki+oR6sOnb7o/ih9Qw
	37TABIjyBg=
X-Received: by 2002:a05:7301:d198:b0:354:53af:7f2 with SMTP id 5a478bee46e88-35453af114bmr613530eec.11.1791535597166;
        Fri, 09 Oct 2026 01:46:37 -0700 (PDT)
Received: from localhost.localdomain ([23.148.204.128])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-354a52463casm2088166eec.22.2026.10.09.01.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 01:46:36 -0700 (PDT)
From: Wang Zhan <wang.zhan@smartx.com>
To: netdev@vger.kernel.org,
	Joas Antonio dos Santos <joasantonio108@gmail.com>
Cc: Wang Zhan <wang.zhan@smartx.com>,
	Paul Moore <paul@paul-moore.com>,
	Eric Dumazet <edumazet@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-security-module@vger.kernel.org,
	Alice Mikityanska <alice.kernel@fastmail.im>
Subject: Re: [PATCH net] calipso: keep BIG TCP payload_len in calipso_skbuff_setattr()
Date: Fri,  9 Oct 2026 16:46:16 +0800
Message-ID: <20261009084616.139462-1-wang.zhan@smartx.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <179147330473.58090.15760316487710432833@gmail.com>
References: <179147330473.58090.15760316487710432833@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 08 Oct 2026 12:28:24 -0300 Joas Antonio dos Santos wrote:
> @@ -1357,8 +1357,9 @@ static int calipso_skbuff_setattr(struct sk_buff *skb,
>  			sizeof(*ip6_hdr) + start);
>  		skb_reset_network_header(skb);
>  		ip6_hdr = ipv6_hdr(skb);
> -		payload = ntohs(ip6_hdr->payload_len);
> -		ip6_hdr->payload_len = htons(payload + len_delta);
> +		/* BIG TCP packets have payload_len == 0 */
> +		if (ip6_hdr->payload_len)
> +			be16_add_cpu(&ip6_hdr->payload_len, len_delta);

Hi,

I think there are boundary cases around IPV6_MAXPLEN: growing past it
can cause payload_len to overflow, while shrinking below it leaves
payload_len at zero.

Could we use ipv6_set_payload_len(ip6_hdr, skb->len - sizeof(*ip6_hdr))
to set the length here? I haven't checked the details, though.
