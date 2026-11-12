Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794470753;
	b=BZaAsQoXvdZrz6EoSPWqt3o+eT3hhs2YQ/WTm6mVV6fPAAAphkKsyiRG8qK3K/qmYGg/
	 PTD8xBV8nDfB8BqNBo/DU3I/ag69F/bVwsrToUby6uLCn4jNaIQxqRU4TBbhC4qKTXN3R
	 7R7EyNwBktEp6JJ01zuPa6VgqBhpDI0mPDodwSRMxaIRILvNCY29vMRvrYyX+KtVDhXgt
	 R4rjgIy60jQjJwd54v2NpMVV/KMOcpycpVXzScFuOZ4t73gkEhxo4Tn4cBuqfdnAV1Yh0
	 LoLNFZyNQ5Lz9JyRuVO469JEIjqpT0FKXPlSj9A6GZzaa728d5c2KxHesmsmeIUIfaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794470753;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=ArZiWLhorJw5ucRbxV10l7039zDtSIU3wClqZur+OXY=;
	b=4Kl4urP6JLuYKHYCgXb+h0ERXbFPMch/2hQ0v/4fPYxMJmYK66P38rw95vZUwS7WnVww
	 /6BYGk5iph/YZeLw+lujZY/2IA9xd4iy4Js2nP47KLdzTqV3s8WZsLsGjMUmSXDDzXoED
	 znt+XurqMNUacpwYQcwnfxGNuak2khtX76Off28i64TP1+7b149PdFRln6zSUvJ6jfIKl
	 aBfS+utxo3M4lfdlV6Ozd9X8cZJrv790KyqilKHBQWf89yZsJOHzgyyCrEs+ITbln0Vwd
	 qkxfk6WU6Q7YdTpT3dUPmDmGQPkrWFQttB7z15cY9giX2LSUZnLgV0gvJjBZtOCHbFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ShXJCZZh;
	arc=none smtp.remote-ip=209.85.221.50
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FD7606A323
	for <linux-security-module@vger.kernel.org>; Thu, 12 Nov 2026 08:05:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E6FD7606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ShXJCZZh
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-490d59c3f0aso2117377f8f.1
        for <linux-security-module@vger.kernel.org>; Thu, 12 Nov 2026 00:05:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794470751; x=1795075551; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ArZiWLhorJw5ucRbxV10l7039zDtSIU3wClqZur+OXY=;
        b=ShXJCZZh3r9hFJDuUtCPJodlUXkqzCQOB1+2EM+MSr2/BQ2FkFGpi3pTNh8on5CIZe
         NeKY6TOgYXAOV9MBu8ZCuCDVW3yAwkNFoXm4XT0u+zdX3SgHGxcqUP3q1yLvYlH5XNR0
         L4IWOvBvhJmsslkJWEApkZvYW26ZB4wbfp1gy7orV7SKYNr4MbfW68n+F2/9eSWiKhU3
         I4HI2plZjvrsHr8QtqDzGKaHnbi+EuaqhixeGOb8ZFGL3gicwGhpvlFsD6E+/c9fLVom
         3chpV30pWkbX8LF57Km0CQekllGUhf3lmCNsHQp9/sBmyShviBOHBFxDw3lokCUGQWf9
         Ob9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794470751; x=1795075551;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ArZiWLhorJw5ucRbxV10l7039zDtSIU3wClqZur+OXY=;
        b=LMID8GKm0SsdScE9JeFdhLcOZOHo3oR+u7XLzB4BUIkNjC80GxKvjB4tVnhJP10zYi
         AXfikAf5sFDW9G0cRUZXRWwHJhSSOnE/4FeZlPNNUrnDAms9Fgq2Cte3uiORxMhhylHn
         x1A3izID0UqB8pW0bmm+QlptNvVemmK6VOkSXCJXUNeCwJUR1ABStWu9b3zaAmB7cFF5
         ALfC9fXOP2Q+gXwDN9Ic6DVX492buqvglqcbmLcTmhoZG2U+ERUVjIVBQFIUDps7iVH2
         cq8A2kp5DeZfopjk7G3mgI/MUPkT0cvLUvg0WlWHGHW7V8orNHk0QC+j8aAxGE8eR+Ub
         xNgA==
X-Forwarded-Encrypted: i=1; AL+hErHYIKoJKUUEAJUnYSSRgwY9SvF5tLcFO0dcg0xF3OpF1gj5E8WFz8zmgNhltUSGCwnV4OfN0EHIyaAmFDF0Mo2LqgDxZNE=@vger.kernel.org
X-Gm-Message-State: APuU4Z90SwfveDILVsegy+OqMyh9kMNwbampkZrKmauocXoA9gyCGQai
	Q87A0PMAOj5haeQsm6YJ5LzBuhRFZjCHL/ETvz4PrKvIJ2Zj9h2p1XQJ
X-Gm-Gg: AYBFou2GCtZx4IDjwKyp2BeGpou/7rqncHvRkhiRlZmSIzFdeId7C+Rbh9IPj8tHEDz
	mHzEpEoO/+G7ZCAMZT8xMgMwwd5ivdwy/gk3nbMKsuZgUeT32Z2cOcMe/Rrxxp+QcaLlR/00gjY
	0TS4lDseI4vS6hzL8At9aSUT5QqeJTvl9hOReKIUgAiLzoq1rlxgLpH5MRJQBCcdJBN0E0tLopy
	1fVT/wL8mfUk8/w7zB9wr1+lHgLPT6jhLK86yaJvAe16vIxwiauktNfhxd3iLqvQMAkkD2irPZR
	7tSuGsGsQg0VFIpjWYWdp8CokK9N1rDW8JecvQeRFFSNzEMrIpvM6QEYtM6HM/QB/v16dFia1Ac
	IzM6PeAUxEz/1nZobDXPpXqA0kAz7bRgqQFLhOcHZr9QTtzb3FFTN9TOQuIQg0T77t7kOJAAb7n
	Evh7IzeSZX9zyZbZYq+KBLHYkGZ/q5zMB6FyinqfWbZcDG6oWof49kk++3IXT4bTneWJeldwnUP
	HtQ6R72Msv3mYZHWF3h0Dpjo2D34AZHT2H8LyiKvZxLK9GzBlnLxWkrsJJAPt2BwW8sS7r4MY8l
	COK9KPN6j8V2cq/1tG6/IPhmKrW/TWE2hVd1BdUZSYWUZLaCsQBuNA==
X-Received: by 2002:a05:6000:4b0b:b0:492:b5d9:f627 with SMTP id ffacd0b85a97d-499c8796888mr7998443f8f.46.1794470751084;
        Thu, 12 Nov 2026 00:05:51 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4983585923bsm15722919f8f.11.2026.11.12.00.05.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 00:05:50 -0800 (PST)
Date: Thu, 12 Nov 2026 09:05:49 +0100
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: pandaWall <mangosteen922@126.com>
Cc: mic@digikod.net, gnoack@google.com,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] landlock: Fix layer composition of
 LANDLOCK_ACCESS_FS_REFER
Message-ID: <20261112.cb77bc01c8a6@gnoack.org>
References: <20261112025528.443654-1-mangosteen922@126.com>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261112025528.443654-1-mangosteen922@126.com>

On Thu, Nov 12, 2026 at 10:55:28AM +0800, pandaWall wrote:
> landlock_get_fs_access_mask() unconditionally ORs
> _LANDLOCK_ACCESS_FS_INITIALLY_DENIED (i.e. LANDLOCK_ACCESS_FS_REFER)
> into every layer's handled filesystem mask.  Layers created from
> rulesets that only handle other rule types (network ports, scopes) or
> only permissions therefore report REFER as handled even though
> landlock_upgrade_handled_layer_config() only adds the bit when
> handled.fs is non-zero, and no filesystem rule can ever clear a bit
> of such a layer.
> 
> The consequence is that stacking any non-filesystem ruleset on top of
> a filesystem ruleset makes link(2), rename(2) and
> renameat2(RENAME_EXCHANGE) fail with -EXDEV/-EACCES even when each
> ruleset individually allows the operation: landlock_unmask_layers()
> requires every layer's mask to be cleared, and a non-filesystem
> layer's mask can never be.
> 
> Only implicitly handle REFER for layers that already handle
> filesystem access rights.
> 
> Fixes: fff69fb03dde ("landlock: Support network rules with TCP bind and connect")
> Signed-off-by: pandaWall <mangosteen922@126.com>
> 
> Add a corresponding regression test to the layout1 fs_test suite:
> stacking a network-only ruleset (handled_access_net only) on top of a
> filesystem ruleset allowing REFER and MAKE_REG must not deny
> different-parent rename/exchange.
> ---
>  security/landlock/domain.h                 | 15 +++++++--
>  tools/testing/selftests/landlock/fs_test.c | 37 ++++++++++++++++++++++
>  2 files changed, 49 insertions(+), 3 deletions(-)
> 
> diff --git a/security/landlock/domain.h b/security/landlock/domain.h
> index 935e18b12..07d4a23fc 100644
> --- a/security/landlock/domain.h
> +++ b/security/landlock/domain.h
> @@ -262,9 +262,18 @@ static inline access_mask_t
>  landlock_get_fs_access_mask(const struct landlock_domain *const domain,
>  			    const u16 layer_level)
>  {
> -	/* Handles all initially denied by default access rights. */
> -	return domain->layers[layer_level].handled.fs |
> -	       _LANDLOCK_ACCESS_FS_INITIALLY_DENIED;
> +	access_mask_t handled = domain->layers[layer_level].handled.fs;
> +
> +	/*
> +	 * Only layers that handle filesystem access rights implicitly
> +	 * handle REFER.  A layer that handles other rule types (e.g.
> +	 * network, scopes) must not imply REFER, otherwise it would
> +	 * spuriously deny link and rename operations.
> +	 */
> +	if (handled)
> +		handled |= _LANDLOCK_ACCESS_FS_INITIALLY_DENIED;
> +
> +	return handled;
>  }
>  
>  static inline access_mask_t
> diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
> index f725882fa..5588f0ee5 100644
> --- a/tools/testing/selftests/landlock/fs_test.c
> +++ b/tools/testing/selftests/landlock/fs_test.c
> @@ -2570,6 +2570,43 @@ const struct rule layer_dir_s2d1_execute[] = {
>  	{},
>  };
>  
> +/*
> + * Tests that a layer not handling filesystem access rights does not
> + * implicitly handle LANDLOCK_ACCESS_FS_REFER, which would otherwise deny
> + * different-parent renames and links stacked on top of a filesystem ruleset.
> + */
> +TEST_F_FORK(layout1, refer_with_net_layer)
> +{
> +	const struct rule layer_fs[] = {
> +		{
> +			.path = dir_s1d2,
> +			.access = LANDLOCK_ACCESS_FS_REFER,
> +		},
> +		{
> +			.path = dir_s1d3,
> +			.access = LANDLOCK_ACCESS_FS_MAKE_REG,
> +		},
> +		{},
> +	};
> +	const struct landlock_ruleset_attr ruleset_net = {
> +		.handled_access_net = LANDLOCK_ACCESS_NET_BIND_TCP,
> +	};
> +
> +	/* layer_fs alone: different-parent rename is allowed. */
> +	enforce_fs(_metadata, LANDLOCK_ACCESS_FS_REFER |
> +				      LANDLOCK_ACCESS_FS_MAKE_REG,
> +		   layer_fs);
> +	ASSERT_EQ(0, test_rename(file1_s1d2, file1_s1d3));
> +	ASSERT_EQ(0, test_rename(file1_s1d3, file1_s1d2));
> +	ASSERT_EQ(0, test_exchange(file2_s1d2, file2_s1d3));
> +
> +	/* Stacks a network-only layer: still allowed. */
> +	drop_access_rights(_metadata, &ruleset_net);
> +	ASSERT_EQ(0, test_rename(file1_s1d2, file1_s1d3));
> +	ASSERT_EQ(0, test_rename(file1_s1d3, file1_s1d2));
> +	ASSERT_EQ(0, test_exchange(file2_s1d2, file2_s1d3));
> +}
> +
>  /*
>   * Tests precedence over renames: denied by default for different parent
>   * directories, *with* a rule matching a parent directory, but not directly
> -- 
> 2.56.0
> 

The same patch (with the same subject live even) was already sent by me in [1].

If you are serious about sending kernel patches, please:

* Start at patch version 1, not 2.
* Send new patch versions as top level threads.
* Wait for feedback before sending V3.
* Clarify in subsequent versions what the difference to the previous one is.
* Contributors must use full names in their submissions, as Sashiko also remarked.

This is wrong on multiple levels and looks suspiciously like it was
lacking human supervision?  In case this was an AI bot, please don't
let your AI bots loose unsupervised on the kernel mailing lists.

Thanks,
–Günther


[1] https://lore.kernel.org/all/20261108-b4-landlock-refer-nonfs-layer-v2-0-2b405fc1b3aa@gmail.com/
