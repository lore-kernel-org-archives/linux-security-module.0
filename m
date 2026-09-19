Received: from mail-pj2-f42.google.com (mail-pj2-f42.google.com [74.125.227.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2196239B49D
	for <linux-security-module@vger.kernel.org>; Sat, 19 Sep 2026 21:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789854773; cv=none; b=WpOTRjz4No5Me8eVbYyhGduOz9iyJWpj8D2r5fDEblPyz9EnCzAQoFGcsBwhqVTVnRICr5rsWxCAsOvo8iIrXbZQ4XY3FKv9Xxt5zF1HF4d2UKm700QmCUi+pNhtaudZ0fvGdZYr8X2oXyPxhRzEVefZLFtyg2OQDoZT2+ZaaRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789854773; c=relaxed/simple;
	bh=Dtow7kJqEeyZW2h3uJ13cQiL5/BpRJhEJ70CB5MBkcs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u7Goltbn0rORIaoLODxZSxXSp5WZyROVHSg9Taxh43LV02AdSa8N6g0jmic+EcwDo6Ykb9XV+qdB+trVHBUza8++gP20oWDZMRqsZvwOVt+enJ/+ipcLORSjSnFMynf4uYDPPHItZHu9h0aS7eaBQZgKUaWMtpuLwUTxqQR1zfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eLs/0Q8z; arc=none smtp.client-ip=74.125.227.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eLs/0Q8z"
Received: by mail-pj2-f42.google.com with SMTP id 98e67ed59e1d1-3a02902dce2so274149a91.1
        for <linux-security-module@vger.kernel.org>; Sat, 19 Sep 2026 14:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789854764; x=1790459564; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nH5MPo1KuhWG3KVnvfVUYVHgxolmH4XOxGLTnjREHd0=;
        b=eLs/0Q8z6SfyHeSw8jiJ/ddNXLoEa+hQw31KvqOxO09CWgSOgMmUjpkVIlHUsMY5yx
         JJEYhftovrKOgqKPHBFKmVG/MC6dj16IJP6SQvowC2Y+bNS88AesmEtOra8wHicSgMy5
         jIzCinovpOHLWzcHnYa3cr7Q6o+1eI4CX/yXBb/aZUyi5cBKfzxVLQOQLzG7XbEJpEL8
         1DCduwh0deLq/lZ7GOr6NdFpq1UQ/+0uF/Nal26hT/spwzFCW+h1hW9dc+OQoKu6PwtK
         s7gVVYvtstK1kxHJpBZiOpypPE+IsDUFFNh74o366fMYzEU4wZMtiaUjkw3hLuLhbQUp
         2KWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789854764; x=1790459564;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nH5MPo1KuhWG3KVnvfVUYVHgxolmH4XOxGLTnjREHd0=;
        b=q0eouwsY4KPyDXcKGOONT18tth8peB10y6m+iCFdlTxrPCXWG/0G1Oit92B0dp2sJ8
         PNfL5xggHD9H1a0W2F1e2LCacDrP0iJCv9HaIgtWes2Mc/pDvRPkBHSWYjwJF4hMwfYC
         CCyqAwKjEMyUtxnxV7kpSCizJLsu4M0uRynTN/v8x5rmlKoLQKkCFJh5V/nxWU25jyC8
         6c1LY5QzTRp/5vWxrhB/9r9dtD3hOx4MZSm39hK4nQXZfR40597MPX4J8Sw11wDZf1gc
         R/cAd/M3XsCfH0/9T4xVp6iWW5Oi92sgNZ09o8utC9xqZtx41E+yqEY75gQaDYgCPZzg
         eGeA==
X-Forwarded-Encrypted: i=1; AKwUvBwimo9bXgAM7oyT6Lq5EVTM67UcocoulAE1jZ2uawlThDaZCv8Ksmz0eZ1dQzyguO5ohdrjjbAWy+CIu7U5bd1HOTWjbYE=@vger.kernel.org
X-Gm-Message-State: AFuF++kUo1Rw0M16FFBHAfLKttKtwjFKx1Bg2cajjb5UNqtnCmNozUBT
	ytVh0VDGhxTQ9SOgf8N4U97/1i0ftC8PkhfC/WqZDX6QY6JIT/VcqtefHZY85Cxd
X-Gm-Gg: AYBFou1RXbzzK0eZaXxQ9b9sRlQ0p3MAU2Ph8bmdug0FzylnXn5PUsl8dm3tVX0YAZi
	woI1SFA/c3naf4/JTDOBmv0/KlMm9FxjhdQ0VpKyjImJYs+fOjNNaEmNcCg15qP2usuKBjseJZO
	vLyn5tRXkSoaLu/WttDreoEENBRLZPXFT563FX2Cm+TG1a3yyOAoefqSTFMrv6SSlZhI7LKKCh+
	aLqxEcUSCs+O/XDeHEa+R+g5PdZcfHfwroO8AZxfaO/iKUuE9K/GTc0r74ST4eeXiN1OpYjj3CZ
	7USOgsGKj80H/+Xw8ZTbJCEukFYcFzJ1g8dPKCfdR+0WeAcUczaoYJ8HHYs/d9FWd5ItgZ4jh7J
	PVJ9GpJaJjiwAu/g3ubV+sk559sYZs35v/Xe9HfaxTRfOGJP6uRlAsVKzGVbUeEaf+SdzkUu9at
	8KJwT/PkD5xcfhTLPg4fCIzfN61HHjHsR1+fMOnc8b3JAWKyznLgIBYCiQvgjN4tyMdEi3pusRO
	6dkYnuwDwJm/1o8Q0matio7GC8r/4WlUb57riGs2dyn2f7qhnsKxzXMtakaOcyiIs70YfiTcHwF
	3UCCFHVHng==
X-Received: by 2002:a17:90b:2649:b0:39e:3713:c2e4 with SMTP id 98e67ed59e1d1-39e54dce754mr12273981a91.14.1789854764308;
        Sat, 19 Sep 2026 14:52:44 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a02900f84fsm4226219a91.2.2026.09.19.14.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 14:52:44 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: paul@paul-moore.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] netlabel: cipso_v4: reject empty MLS level/cat lists and zero tail in cipso_v4_delopt()
Date: Sat, 19 Sep 2026 21:52:43 +0000
Message-ID: <20260919215243.3472150-1-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix three bugs in NetLabel CIPSOv4 handling:

1. In netlbl_cipsov4_add_std(), an empty NLBL_CIPSOV4_A_MLSLVLLST or
   NLBL_CIPSOV4_A_MLSCATLST leaves local_size or cipso_size at 0, causing
   kcalloc(0, ...) to return ZERO_SIZE_PTR (0x10), which bypasses NULL
   checks and installs ZERO_SIZE_PTR arrays into cipso_v4_doi_list. Reject
   0-sized level or category tables before allocation.
2. In netlbl_cipsov4_remove_cb(), also inspect NETLBL_NLTYPE_ADDRSELECT
   entries so IPv4 address-selected domain mappings referencing a removed
   CIPSOv4 DOI are properly cleaned up.
3. In cipso_v4_delopt(), zero the trailing cipso_len bytes with IPOPT_END
   after memmove() and pass opt->opt.optlen - cipso_len to
   cipso_v4_get_actual_opt_len() so stale tail bytes are not re-parsed.

Fixes: 96cb8e3313c7 ("[NetLabel]: CIPSOv4 and Unlabeled packet integration")
Fixes: 389fb800ac8b ("netlabel: Label incoming TCP connections correctly in SELinux")
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
diff --git a/net/ipv4/cipso_ipv4.c b/net/ipv4/cipso_ipv4.c
index a05aa075de1a..4ac1a4965abe 100644
--- a/net/ipv4/cipso_ipv4.c
+++ b/net/ipv4/cipso_ipv4.c
@@ -2025,9 +2025,11 @@ static int cipso_v4_delopt(struct ip_options_rcu __rcu **opt_ptr)
 
 		memmove(cipso_ptr, cipso_ptr + cipso_len,
 			opt->opt.optlen - cipso_off - cipso_len);
+		memset(&opt->opt.__data[opt->opt.optlen - cipso_len],
+		       IPOPT_END, cipso_len);
 
 		optlen_new = cipso_v4_get_actual_opt_len(opt->opt.__data,
-							 opt->opt.optlen);
+							 opt->opt.optlen - cipso_len);
 		hdr_delta = opt->opt.optlen;
 		opt->opt.optlen = (optlen_new + 3) & ~3;
 		hdr_delta -= opt->opt.optlen;
diff --git a/net/netlabel/netlabel_cipso_v4.c b/net/netlabel/netlabel_cipso_v4.c
index b080e666523f..9bb28236b8fe 100644
--- a/net/netlabel/netlabel_cipso_v4.c
+++ b/net/netlabel/netlabel_cipso_v4.c
@@ -185,6 +185,9 @@ static int netlbl_cipsov4_add_std(struct genl_info *info,
 					break;
 				}
 		}
+	if (doi_def->map.std->lvl.local_size == 0 ||
+	    doi_def->map.std->lvl.cipso_size == 0)
+		goto add_std_failure;
 	doi_def->map.std->lvl.local = kcalloc(doi_def->map.std->lvl.local_size,
 					      sizeof(u32),
 					      GFP_KERNEL | __GFP_NOWARN);
@@ -260,6 +263,9 @@ static int netlbl_cipsov4_add_std(struct genl_info *info,
 						break;
 					}
 			}
+		if (doi_def->map.std->cat.local_size == 0 ||
+		    doi_def->map.std->cat.cipso_size == 0)
+			goto add_std_failure;
 		doi_def->map.std->cat.local = kcalloc(
 					      doi_def->map.std->cat.local_size,
 					      sizeof(u32),
@@ -680,10 +686,21 @@ static int netlbl_cipsov4_listall(struct sk_buff *skb,
 static int netlbl_cipsov4_remove_cb(struct netlbl_dom_map *entry, void *arg)
 {
 	struct netlbl_domhsh_walk_arg *cb_arg = arg;
+	struct netlbl_af4list *iter4;
+	struct netlbl_domaddr4_map *map4;
 
 	if (entry->def.type == NETLBL_NLTYPE_CIPSOV4 &&
 	    entry->def.cipso->doi == cb_arg->doi)
 		return netlbl_domhsh_remove_entry(entry, cb_arg->audit_info);
+	else if (entry->def.type == NETLBL_NLTYPE_ADDRSELECT) {
+		netlbl_af4list_foreach_rcu(iter4, &entry->def.addrsel->list4) {
+			map4 = netlbl_domhsh_addr4_entry(iter4);
+			if (map4->def.type == NETLBL_NLTYPE_CIPSOV4 &&
+			    map4->def.cipso->doi == cb_arg->doi)
+				return netlbl_domhsh_remove_entry(entry,
+							cb_arg->audit_info);
+		}
+	}
 
 	return 0;
 }
