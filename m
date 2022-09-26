Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A221C6FA82
	for <linux-security-module@archiver.kernel.org>; Mon, 26 Sep 2022 04:10:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbiIZEKM (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 26 Sep 2022 00:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbiIZEKK (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 26 Sep 2022 00:10:10 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2414418B07;
        Sun, 25 Sep 2022 21:10:10 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id q35-20020a17090a752600b002038d8a68fbso11223091pjk.0;
        Sun, 25 Sep 2022 21:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=QXx7+gasdp/tRu8MKoP7DQMufnq8TjN+RgzEpBKVsEw=;
        b=aRBd+tNx7vgqnqHU4SI2W50W4viohf76z7y+HybIy83QPiBCiVfmmO22HrUObPWdc0
         +GArZinaDp/xTtreqi8xIEDrlsbZBtu/gS+xon4xBG/VNd3+EzehGSew2HHuR5HZwEpw
         5zy7clQcMdH63b/VDXpsJx4IYn/BKrPnA/9bzOzahX0VFg1x2If9dnrxvvQquihyX2Js
         V2u9FyRXUDRwWjO67TueMrYhM9RJzGPwoSaMBoRoXcOUM0sUbOienLLNxbVU5Tz65JDN
         DjGvJs+LDbxtM1C+QLHspsVYUqkBrFq10wPVzDgG9CdtKZNFSfGu+OHC4FYQ/1CLsAsG
         JovA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=QXx7+gasdp/tRu8MKoP7DQMufnq8TjN+RgzEpBKVsEw=;
        b=EC9bUshVUmLTJUjiZ9OoYIUicD9bxC6AgzLjWT8XwGbOULZ8cACxZtzILtEgsc8NrP
         Naly0BloFfVNYPu0Y3Pj/56hDMWxxdgveF0/9c2Q+X0WNCCqnbfdSEuftSSkBTmrpum9
         ve5r2cZ2nmnIullltYFLjzWyRPoRJStY11THKlQ6jvphuKh54FjH4BX1s8AzFHre99v2
         Ns3rTz5fKF47YTSv/xHT0PEIWRKyS2hwJW1wdTpLamSy75saWccKDvpALOT1Z13T8/Az
         rMAutnhnr2LOU4F8HR8bKrtmk1ViwBHv8EK4T8HXOp3d2NqG2uNu7c9OgUNJZYJDgJhT
         nSXA==
X-Gm-Message-State: ACrzQf3TosknIfeu0TMzRPI4qXUUv3KMvyc6LAi16wWDv6hSecRPxVNO
        +ZBeGYS3x7JpvY/A/bBjJUg=
X-Google-Smtp-Source: AMsMyM4RANYU/mCUOSxvA5XQCTiwf3Fb28XPjlF+w3taGFwXYuC1AWVPtxTdsIMOxHnr75Ho7qj+Mw==
X-Received: by 2002:a17:903:264e:b0:176:e9d3:64b6 with SMTP id je14-20020a170903264e00b00176e9d364b6mr20468288plb.172.1664165409633;
        Sun, 25 Sep 2022 21:10:09 -0700 (PDT)
Received: from [192.168.11.9] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id e6-20020a170902d38600b00173411a4385sm10051455pld.43.2022.09.25.21.10.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Sep 2022 21:10:09 -0700 (PDT)
Message-ID: <19799dac-6e16-83d8-c21e-eb0895dda108@gmail.com>
Date:   Mon, 26 Sep 2022 13:10:04 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v1 2/3] landlock: Slightly improve documentation and fix
 spelling
Content-Language: en-US
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     alx.manpages@gmail.com, corbet@lwn.net, gnoack3000@gmail.com,
        jmorris@namei.org, konstantin.meskhidze@huawei.com,
        linux-doc@vger.kernel.org, linux-security-module@vger.kernel.org,
        mic@digikod.net, paul@paul-moore.com, serge@hallyn.com,
        Akira Yokosawa <akiyks@gmail.com>
References: <Yy8GNAAmq6t6Kt66@debian.me>
 <9055c684-bfd0-10b2-7209-7b9898f05a88@gmail.com>
 <964ecd62-7684-6d7c-c801-25907549f0bb@gmail.com>
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <964ecd62-7684-6d7c-c801-25907549f0bb@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, 26 Sep 2022 08:46:18 +0700, Bagas Sanjaya wrote:
> On 9/26/22 08:09, Akira Yokosawa wrote:
>> Wait!
>> Bagas, your suggestion is _against_ the preference of kernel documentation.
>> See https://www.kernel.org/doc/html/latest/doc-guide/sphinx.html#cross-referencing
>>
>> Or do you have some good reason to add labels at the beginning of
>> rst docs?
>>
> 
> Ah, I don't see that :doc: directive is possible in that case, thanks.
> 
> BTW, I prefer the link text be not full path to document (like
> Documentation/path/to/foo.rst), but rather either the linked doc's title
> or custom text.

Again, your preference is _against_ the preference mentioned in the
cross-referencing section, quoted below:

    For most use cases, the former is preferred, as it is cleaner and more suited
    for people reading the source files. If you come across a :doc: usage that
    isn't adding any value, please feel free to convert it to just the document path.

        Thanks, Akira

