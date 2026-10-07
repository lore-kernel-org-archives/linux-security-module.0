Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6EE2AD35
	for <linux-security-module@vger.kernel.org>; Wed,  7 Oct 2026 15:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791386762; cv=none; b=CupsCsfYaZcLOfv8lEn0eEHr5tchRAhU655ms2bfsFbNljieilOWzKOOqlI+7HFFgIVyeg8bh50t0NCQ6+3lMyfrviXpl/dUfA7um5RB65j0chU51FX07Mv6/uGXB3U5+l5m33T6DLHRb8MsZ9IddjJZ59q2P5voltpnpcRlFig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791386762; c=relaxed/simple;
	bh=tvemIKvYgfbYm7QKksQYum/A3YjRyh2EfYOVMIXdi2c=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=k+WnlaP01L7U18ao+6cHL+xMrhm+7YVUr7QsnSCSbaQDOrutUUjR3s+n2z3c+zQTgxGv2AW2h+xHf/5X2yqzicgnvreHJiL4iIh7Jaeoluam7f4osuthDIxddgvD2fP4AEQ+fQwYkP1qlzeaGBoQS35Z24XC+8e0FFxwR2hejp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iKhcFoLy; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iKhcFoLy"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-35120d43ecaso6247502eec.1
        for <linux-security-module@vger.kernel.org>; Wed, 07 Oct 2026 08:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791386756; x=1791991556; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MQUOWsr9zvUEMbXYRqNDHSAxRDOWBUts+dm4K0R8YRE=;
        b=iKhcFoLyFX5JHJEwk08FmbFHu1YBhJEui2yWzIyk9EdHWzhtiSGKvfzSFK9v2aKusE
         YQDP6YO4qW5zzXLJ2MMVV39FeJHcFOQotK1osjLXeMvLxsLpn7vyogVJoNpwnN4IPlHC
         J+WLcHY804/KnX2RFPJ50X7PeSuVIhj8G88/zPncaomZ9A+UfV1twTq0GQVK3xPVYy3y
         2kw1FDjgSCwFyAQ1KITilvz1fvpTWmNJuczGnXpG1SMr8E9UKkngf04EWgCrlme2OUFk
         XgTZg99GuBuIVoQdEwTlaQ272IFNy99j2BFQLMHhRonmTAkLC82er9YHc5DKScHGkVKA
         E8wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791386756; x=1791991556;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MQUOWsr9zvUEMbXYRqNDHSAxRDOWBUts+dm4K0R8YRE=;
        b=gnWH5vGzfqpDdt8CJgYN646ci7Hfm1hkq1u8N9yGeCRue4JXMQW+2GLIUsyY8ZwOVR
         OGjewrdCDAWOckqn/D6Xc8FLjBYxm3nmWXfsoU+glxDGFBGFZARo/FBDwewcNV2JxWhn
         ccc8xIyY/WBMQPZRlK9XqK5eXJOnDLu6U8xoegPHxv0FCfCqsBXf7LwEnCcgWy/euP9m
         6OW28tD8kgqEppIFl5e6CCOg1RyMMdCks/0dTl6mvqQ+z5W84YYWzptB28Rp8ym10nqw
         o9QYmmKmEgIKP/5jI1GQV5jqA6jg8ipmYH4E/vN/fT/7oA/LiCWixnJZgBxOKHEtGrwb
         fklQ==
X-Forwarded-Encrypted: i=1; AKwUvBwRtvD4XzpCmrEsxAREeCF/4QYpoJ3GovKGvyCFkow+hZ+S+HznufGEb1BO9MiNtEhYRRF454EDz4svKSdzj9N6TCEar+w=@vger.kernel.org
X-Gm-Message-State: AFq9FYL+B7IOhidh+bmPmsKJscELBHRJiKQM7NELjW48KzAHpkDQAqjE
	YJn/gbJTzktU7vKnS7iPdQ7QILX2/e4Rxg3K/eknW/O7+WDGLS3oxCK9
X-Gm-Gg: AYBFou1wb9yA6si79ZOIqW+YOXaXA7LOcjgwlr3ntgpiYgByN3dZmtNjTuNnTG2Hl6b
	m6h65bd3GkCauSm7vOYiiqTIVgp+x2HzLpPDvB+INBTazUQTQNRUZ8ObEAtFy7+X8NwOvmXtcuq
	yUF1bWd3zQzf49KueHwCyGtai5IOmItZirttl9M+ee0PzxHsD+WcFcGnNU9IH9gYDHJSwYjvEZr
	CpZfoCVwdfVkBQT3pXh8UDFozR1N94tye143ahhT5XhO73oKYN+XDxc7xfLlufAEKyYLSp8jECl
	CZO5rpDUK/aBQIu9Icf/o1kOsrUO7n5GO5gYy2vDfMmLR/KhAc4B0Z4KiruKin8iCMMqo1hmuI8
	3sLdYocNHznTQpljuIUXxJlNDiZb6QKspDzTxeDudy6DBFU9t/yhKtovpDTZWwSZ9NuhMTEiNEt
	bZ8xFQYat/Y+wm/Z2FyWtOd6sRVpU5VWhFXQ2M7Ycz6BNV0hvZgnRTXXpaYV/tBnp7BDw8ksXyl
	lR4f4Q0bwt4HeHdXUWYnJd6MslpE5N4APQM7qXMCpzQgG2d33JZuleewzAzrqiKIxM+mFI1YY3k
	LNPdh/V3kBtiUOOfiTQQZxAKzneevICu/l66odfLX3vGYz4S17uVsxfQ4WF5SP0=
X-Received: by 2002:a05:693c:895c:10b0:34c:7e54:65e6 with SMTP id 5a478bee46e88-3515db9c59bmr2624192eec.5.1791386755664;
        Wed, 07 Oct 2026 08:25:55 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([95.173.223.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3515af26f10sm9234416eec.13.2026.10.07.08.25.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 08:25:55 -0700 (PDT)
From: Joas Antonio dos Santos <joasantonio108@gmail.com>
To: Paul Moore <paul@paul-moore.com>
Cc: David S. Miller <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 linux-security-module@vger.kernel.org
Subject: [PATCH net-next] calipso: hash the cache key, not the option start,
 in calipso_cache_add()
Date: Wed, 07 Oct 2026 12:25:00 -0300
Message-ID: <179138670045.80227.16155454353416856947@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

calipso_cache_add() stores calipso_ptr + 2 as the cache key, but
computes entry->hash over calipso_ptr, i.e. starting two bytes earlier
at the option type and length.  calipso_opt_getattr() looks entries up
with calipso_cache_check(calipso + 2, calipso[1], ...), which hashes the
key itself.

The two hashes only match on a jhash collision, so the CALIPSO label
cache never hits and every labelled packet takes the full DOI lookup and
category conversion path.  The memcmp() on the key keeps lookups
correct, so this is a performance bug only.

Hash the stored key, as cipso_v4_cache_add() does for CIPSO.

Fixes: 4fee5242bf41 ("calipso: Add a label cache.")
Signed-off-by: Joas Antonio dos Santos <joasantonio108@gmail.com>
Assisted-by: Claude:claude-opus-5-5
---
Found by code review.  Compile-tested only (arm64, W=1); not runtime-tested.

 net/ipv6/calipso.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv6/calipso.c b/net/ipv6/calipso.c
index c072eca50..8c447d860 100644
--- a/net/ipv6/calipso.c
+++ b/net/ipv6/calipso.c
@@ -283,7 +283,7 @@ static int calipso_cache_add(const unsigned char *calipso_ptr,
 		goto cache_add_failure;
 	}
 	entry->key_len = calipso_ptr_len;
-	entry->hash = calipso_map_cache_hash(calipso_ptr, calipso_ptr_len);
+	entry->hash = calipso_map_cache_hash(entry->key, calipso_ptr_len);
 	refcount_inc(&secattr->cache->refcount);
 	entry->lsm_data = secattr->cache;
 
