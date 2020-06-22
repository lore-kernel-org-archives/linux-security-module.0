Return-Path: <SRS0=WgAi=AD=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D72C433DF
	for <linux-security-module@archiver.kernel.org>; Mon, 22 Jun 2020 09:40:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1E3A20732
	for <linux-security-module@archiver.kernel.org>; Mon, 22 Jun 2020 09:40:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent-com.20150623.gappssmtp.com header.i=@isovalent-com.20150623.gappssmtp.com header.b="CloD2p5I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726790AbgFVJku (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 22 Jun 2020 05:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726776AbgFVJkt (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 22 Jun 2020 05:40:49 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14036C061794
        for <linux-security-module@vger.kernel.org>; Mon, 22 Jun 2020 02:40:49 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id a6so13981531wrm.4
        for <linux-security-module@vger.kernel.org>; Mon, 22 Jun 2020 02:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tOdN8Os3uQ1Vbd/a4os7DGJTbk++99An6ASi1Ba/kec=;
        b=CloD2p5IV2JOh6H0z15M5xN+pD/IFDVTRV8gwJl6o7iAUEs0z0BMsK9Y5PhuZBHZgo
         Jvx5hRyJQjVAPdvCcMHLuWk+B3NsTiMoujvQhr6npjcQFct7Fn62NI0gKd7ElDGwsMZY
         cdIfF9paZXIQtJkvcczi0uEGFSKGYf/n1atUAZzId1B9uylH5bKpJnLyrSfZqVTys0co
         +iIPqy9B6m8P/M3NP88RoESotaaTBmKgwFIkok59t0pG4M+r82DP+S64LlgOxem77Tov
         LIxXDcNa1Ia+nbcdoFc/07QpFoM0HEJ2WXmxuDUs58pwx7YfHmPw4WeG5oZMeui15g6T
         xaoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tOdN8Os3uQ1Vbd/a4os7DGJTbk++99An6ASi1Ba/kec=;
        b=r5wUb7g+INlTW0OIqpI95jcKe/7FHLgJ8EuWwA/YQaVAxOdvkBZUoYCf0FJ4F7XUCr
         /yXjdOfBna7jvT+ESEDV5x2IQ0hCzV/uPcloSmXLODVoIpbrC6AnpJtwYL5VFrUfiMdY
         d+SAJVqcGIIDRsC5itQOcOaMKtA7vWVqYQCiQWqpRduSPtKak2kQn5GbFA9IB89nRJ4V
         foD6PgV8yRZLsXqR1m3TvEXLJCiMoCKXM1OeQAzTBd2s6x1RjgjvEqzH53Rf8roDJNrU
         nZtyjnlGZDgehg/KX5LdyH3IWwr+fvWELjWEg35oNXgBUW2XXLLNBbspr0nlZFKU3gwx
         TWxA==
X-Gm-Message-State: AOAM5330/W7QPgp1hce1j7VVM0aLRB8vMzPTPZdYeFDW9JhUQdxAHi3Q
        FtymiO00Umn6H618HhVv9YhrfA==
X-Google-Smtp-Source: ABdhPJx0NL1GSWefd73+pLmzg/cyxn/QzWJMXWk6+Zx1EZmeNfOg2s3SOiG4GF/5Nh84Z5r7vCnAKg==
X-Received: by 2002:a5d:4f01:: with SMTP id c1mr17311626wru.190.1592818847834;
        Mon, 22 Jun 2020 02:40:47 -0700 (PDT)
Received: from [192.168.1.12] ([194.53.184.240])
        by smtp.gmail.com with ESMTPSA id g18sm16038083wme.17.2020.06.22.02.40.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jun 2020 02:40:47 -0700 (PDT)
Subject: Re: [PATCH bpf-next v2 2/4] bpf: Implement bpf_local_storage for
 inodes
To:     KP Singh <kpsingh@chromium.org>, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>
References: <20200617202941.3034-1-kpsingh@chromium.org>
 <20200617202941.3034-3-kpsingh@chromium.org>
From:   Quentin Monnet <quentin@isovalent.com>
Message-ID: <1bb2c24c-bedd-50b4-3d81-3cbb9507ed86@isovalent.com>
Date:   Mon, 22 Jun 2020 10:40:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200617202941.3034-3-kpsingh@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

2020-06-17 22:29 UTC+0200 ~ KP Singh <kpsingh@chromium.org>
> From: KP Singh <kpsingh@google.com>
> 
> Similar to bpf_local_storage for sockets, add local storage for inodes.
> The life-cycle of storage is managed with the life-cycle of the inode.
> i.e. the storage is destroyed along with the owning inode.
> 
> The BPF LSM allocates an __rcu pointer to the bpf_local_storage in the
> security blob which are now stackable and can co-exist with other LSMs.
> 
> Signed-off-by: KP Singh <kpsingh@google.com>

> diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
> index c5fac8068ba1..e8fbafb3e87b 100644
> --- a/tools/bpf/bpftool/map.c
> +++ b/tools/bpf/bpftool/map.c
> @@ -49,6 +49,7 @@ const char * const map_type_name[] = {
>  	[BPF_MAP_TYPE_STACK]			= "stack",
>  	[BPF_MAP_TYPE_SK_STORAGE]		= "sk_storage",
>  	[BPF_MAP_TYPE_STRUCT_OPS]		= "struct_ops",
> +	[BPF_MAP_TYPE_INODE_STORAGE]		= "inode_storage",
>  };
>  
>  const size_t map_type_name_size = ARRAY_SIZE(map_type_name);

Thanks for the update on bpftool map types, could you also change the
relevant help message, man page and bash completion please? (See below.)

Best regards,
Quentin

------

diff --git a/tools/bpf/bpftool/Documentation/bpftool-map.rst b/tools/bpf/bpftool/Documentation/bpftool-map.rst
index 31101643e57c..a9cd15ed7187 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-map.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-map.rst
@@ -49,7 +49,7 @@ MAP COMMANDS
 |		| **lru_percpu_hash** | **lpm_trie** | **array_of_maps** | **hash_of_maps**
 |		| **devmap** | **devmap_hash** | **sockmap** | **cpumap** | **xskmap** | **sockhash**
 |		| **cgroup_storage** | **reuseport_sockarray** | **percpu_cgroup_storage**
-|		| **queue** | **stack** | **sk_storage** | **struct_ops** }
+|		| **queue** | **stack** | **sk_storage** | **struct_ops** | **inode_storage** }
 
 DESCRIPTION
 ===========
diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftool/bash-completion/bpftool
index 25b25aca1112..34cadc081a78 100644
--- a/tools/bpf/bpftool/bash-completion/bpftool
+++ b/tools/bpf/bpftool/bash-completion/bpftool
@@ -688,7 +688,8 @@ _bpftool()
                                 lru_percpu_hash lpm_trie array_of_maps \
                                 hash_of_maps devmap devmap_hash sockmap cpumap \
                                 xskmap sockhash cgroup_storage reuseport_sockarray \
-                                percpu_cgroup_storage queue stack' -- \
+                                percpu_cgroup_storage queue stack sk_storage \
+                                struct_ops inode_storage' -- \
                                                    "$cur" ) )
                             return 0
                             ;;
diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
index c5fac8068ba1..f1b48a97b378 100644
--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@ -1590,7 +1590,7 @@ static int do_help(int argc, char **argv)
 		"                 lru_percpu_hash | lpm_trie | array_of_maps | hash_of_maps |\n"
 		"                 devmap | devmap_hash | sockmap | cpumap | xskmap | sockhash |\n"
 		"                 cgroup_storage | reuseport_sockarray | percpu_cgroup_storage |\n"
-		"                 queue | stack | sk_storage | struct_ops }\n"
+		"                 queue | stack | sk_storage | struct_ops | inode_storage }\n"
 		"       " HELP_SPEC_OPTIONS "\n"
 		"",
 		bin_name, argv[-2]);
