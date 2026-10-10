Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F24331ED5
	for <linux-security-module@vger.kernel.org>; Sat, 10 Oct 2026 09:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791623169; cv=none; b=qK/loq56R2f5aABzsg9kZjPl/ipKep93DVyrkwbDLiaVZl1QhpRxketXPO06SJbNbf4oz7NBVxA+QKPTF8abvaS2/WYyrqBnW+5SS7I718t++WoUgC05EmFc0nFntm75oCwJmazYmpwPHM3TtinXMKSx7bx9QlidxEwLwsU1U2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791623169; c=relaxed/simple;
	bh=cKRxNm86gzxnVgmkPil6uvSeyJZxMrBzx9O2/9KRxls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rjU5qhs6lwyjdgOIyXXp4jkDii3q6+7oIUNHqWnpTh0GGyGeX6foGvbdwleOAoMlZDHeg5rJ1aGlGzGo4OR3N0dwl8QfZU1UJcMN4nBkNEcZCU2bNXcbx7Y5deUpTcP0nUib4nFFV/v+tOe5CIcLhBwru3oNernLGczJNN2GlIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smartx.com; spf=pass smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b=gk+CwX+L; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smartx.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b="gk+CwX+L"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-354ba08cfd1so834222eec.1
        for <linux-security-module@vger.kernel.org>; Sat, 10 Oct 2026 02:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20251104.gappssmtp.com; s=20251104; t=1791623166; x=1792227966; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aZs8U0ZjQ35oS4ozK838xXyPfIOXVraWP2I51EAkJ5w=;
        b=gk+CwX+LRz8ORl6Q0IvKrzDJV+ECVTG7KteaoM7bYAlJHNcSqlRndQPqp+2EsBuYeN
         DWvdQWpevv/vg6KyLfayqYfyHSA87Ty7IaDX/M5wwSUN/qmRiPCeoNkPq8I/IfUD6hHW
         PUgygYE49ss2bZFLxJE06/GYaGtotmcEbGA6CoRINpqY0V/NLICnJYbJDicgTVLfEPkw
         A1M4OL4hG3iJHvozEhyKtCqqBIEXvTp4uJa7uab2bqrFWC9JvqsrARLxZ0gt6hFYBxME
         btA5fdpIC0cmzz4GkT7SeJeXAG7iKFi+NHH6xpEpby0Gbw0AOEx8rcE+ST1WsIuvfRkf
         JJsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791623166; x=1792227966;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aZs8U0ZjQ35oS4ozK838xXyPfIOXVraWP2I51EAkJ5w=;
        b=wSOo+pC6qWBBN8fDxYO5wypWesmXOK9UkdScAMtbeMTyWhxa6LH6DKgNx3xg/BScDX
         /G/x9Eav2TumAzlLBO6ssftp0s53o6wTF33zy/gYOGNWGYiUm0MOPZObXOYyNxG9VMad
         6tclQ6iWOAB9iEgH5yG8qektcJGMx6mBUQAU0IPrRKTrpU3/QfJZLE+xSeI20/QAHHYV
         lTvx/q5tz+U7uqAhSllFuHkX2nZTF/smdhDPgfz5OxT7RFEm9FoaWPzp4hFQZtCdXuCO
         IBpBEbV5H6I9fnpBRtQlC/83+M5pt5bRiM+o87dX4440HudhgwZmy5A8f0PG1gSCChlY
         lpkg==
X-Forwarded-Encrypted: i=1; AKwUvBwtB33FGmWh6NWt/mOKaq6T4xusdkPOsBz/fOccyld/ftDAml8nc/qELt/LOvVI+9hhYSF7WwIRJIglcHpS/JbZ+MV2NbA=@vger.kernel.org
X-Gm-Message-State: AFq9FYKrqSx/IXNuMOAVAHraGkbF0U94u+au5aug1wJ/6MNX1Hll54kj
	NS2yVsIDoiJ3XLjt+YQ2j/M6pjnCKe5SP1G3DDfKuVQQjTyFXGrqrv0TlJqXLhBttCtVswsvTXV
	at1GyqpoWjKgUWmvh3uDVBKMnI7gV570bJ3kLRCc2uEvXRqgAuGruIYIEcrL+wCD5p8BNYEo=
X-Gm-Gg: AYBFou3AxgySKpbQ9KYqXnu/ddndEGBuk5/FqqocMFlo9Tn5tAF05BWidf46JGwR8P8
	QRUQCE/kb4r0GTcPbe37sGV4tkbSpRHzvzx3nqeWnYz4J9H5aKi4lpikrXxx1w4zvsfseD1i8eH
	C/GZm/7q8WPYDBoloIwIrWZVxb5blhRVqaxWx+CEwvdZWhDItK4fiEdwKUgvw16yWGLgCnr/VaP
	ybG5KyZ3OisYowuv1iG+M6oR/6BW8PTEjvVqzVHBYrjY+32x3/7JLiLK1Px/cDizE8+j/+TZODr
	h6x1jhn3YM4mIY14kXqV9mhKOnbsDunv6o8kvVni8EYd15qS44XtJhLgHK5YWQsMBK1XGeAQT7U
	B2iUYwUV9cu1gGX1XoViRb/vK4hyeLmFb5XUGslhmB2qOwP8jr+SYAIw5T/EpoxNmuswA8AM8MS
	ojmyQ6Ow852OvPp91tAAb8IEQUTnDRLq2HnTkVRnofuyrTmSN2pf0tJQJpSZGCcCbzOlID7uYPc
	EQmgyQyHvU=
X-Received: by 2002:a05:7022:ea48:10b0:166:5552:780a with SMTP id a92af1059eb24-16a5afe59d1mr5532791c88.8.1791623165597;
        Sat, 10 Oct 2026 02:06:05 -0700 (PDT)
Received: from localhost.localdomain ([23.148.204.241])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1699718c547sm12212587c88.3.2026.10.10.02.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 02:06:05 -0700 (PDT)
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
Subject: Re: [PATCH net v2] calipso: keep BIG TCP payload_len in calipso_skbuff_setattr()
Date: Sat, 10 Oct 2026 17:05:34 +0800
Message-ID: <20261010090534.317149-1-wang.zhan@smartx.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <179156155963.36253.400481753322266658@gmail.com>
References: <179156155963.36253.400481753322266658@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 09 Oct 2026 12:59:19 -0300 Joas Antonio dos Santos wrote:
> calipso_skbuff_setattr() adjusts payload_len by the length of the
> option it inserts or resizes:
>
> 	payload = ntohs(ip6_hdr->payload_len);
> 	ip6_hdr->payload_len = htons(payload + len_delta);
>
> GRO can build BIG TCP packets larger than IPV6_MAXPLEN, and stores
> payload_len == 0 for them; ipv6_payload_len() then falls back to
> skb->len.  For such a packet forwarded to a destination mapped to
> CALIPSO, the code above writes len_delta (or 65536 + len_delta when
> shrinking) into payload_len, and ipv6_payload_len() no longer falls
> back to skb->len.  nf_tables, conntrack and sch_cake rely on it.
>
> The same arithmetic also wraps when a packet grows past IPV6_MAXPLEN,
> and a BIG TCP packet that shrinks below IPV6_MAXPLEN should get its
> real length back.
>
> Set payload_len from the skb length with ipv6_set_payload_len(), which
> stores 0 above IPV6_MAXPLEN and the real length otherwise, as
> ipv6_gro_complete() does.  The network header was just reset to
> skb->data, so skb->len - sizeof(*ip6_hdr) is the payload length.
>
> Tested on one kernel (arm64, QEMU) with SELinux permissive, a minimal
> mdp-generated policy (network_peer_controls=1), "netlabelctl calipso
> add pass doi:16" and a NetLabel mapping of fd00:2::/64 to CALIPSO
> DOI 16.  calipso_skbuff_setattr() was called through
> netlbl_skbuff_setattr() from a test-only debugfs hook (not part of
> this patch) adding a level-only label; payload_len after the call:
>
>   case                         before fix   after fix   real length
>   1000, unlabeled                    1016        1016          1016
>   70000 GSO, payload_len 0             16           0         70016
>   65530 GSO, grows past MAXPLEN        10           0         65546
>   65540 GSO with a 24 byte hop
>   header, shrinks below MAXPLEN     65528       65532         65532
>   1000 with a 24 byte hop header      992         992           992
>
> (0 means ipv6_payload_len() returns the real length.)  On the forward
> path, with a client injecting unlabeled UDP through a router to a
> server, the router adds the CALIPSO option and the server delivers all
> datagrams (Udp6InDatagrams 5, Ip6InTruncatedPkts 0) with this patch.
>
> Fixes: 81fbc812132c ("ipv6/gro: insert temporary HBH/jumbo header")
> Suggested-by: Eric Dumazet <edumazet@kernel.org>
> Suggested-by: Wang Zhan <wang.zhan@smartx.com>
> Signed-off-by: Joas Antonio dos Santos <joasantonio108@gmail.com>
> Assisted-by: Claude:claude-opus-5-5

Reviewed-by: Wang Zhan <wang.zhan@smartx.com>

> @@ -1357,8 +1357,8 @@ static int calipso_skbuff_setattr(struct sk_buff *skb,
>  			sizeof(*ip6_hdr) + start);
>  		skb_reset_network_header(skb);
>  		ip6_hdr = ipv6_hdr(skb);
> -		payload = ntohs(ip6_hdr->payload_len);
> -		ip6_hdr->payload_len = htons(payload + len_delta);
> +		/* 0 above IPV6_MAXPLEN (BIG TCP), the real length otherwise */

nit: consider dropping the comment, it just repeats what
ipv6_set_payload_len() does.
