Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBCC4C32772
	for <linux-security-module@archiver.kernel.org>; Fri, 19 Aug 2022 09:14:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348008AbiHSJOS (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 19 Aug 2022 05:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348025AbiHSJOR (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 19 Aug 2022 05:14:17 -0400
Received: from smtp-190f.mail.infomaniak.ch (smtp-190f.mail.infomaniak.ch [185.125.25.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68E3D3F1FA
        for <linux-security-module@vger.kernel.org>; Fri, 19 Aug 2022 02:14:12 -0700 (PDT)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4M8GKH2hMHzMrvdB;
        Fri, 19 Aug 2022 11:14:11 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4M8GKG5tC6zlqV0d;
        Fri, 19 Aug 2022 11:14:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1660900451;
        bh=5uB/ueQhhZV6LgsMKipNBiQa1n+SefH6kqOhVl/1cTE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=dJzVmPhMNe0InTafyqAGji5SB4LKCRMx1yr4QCoA0I7e7C8V7FVEllj7wbXiNf572
         38d74VH49gyz8lPZpbp8XA/WW36Wvl9vHeM9iuYMFESu5NkgSQzbpWd3lH2Wcfz11o
         zUswNrsW8o8YEqCgHVSYG8xUz3Q3RhKPeFV7Uq4I=
Message-ID: <b08714ef-e566-4818-ec56-252805fa9de6@digikod.net>
Date:   Fri, 19 Aug 2022 11:14:09 +0200
MIME-Version: 1.0
User-Agent: 
Subject: Re: [PATCH v5 2/4] selftests/landlock: Selftests for file truncation
 support
Content-Language: en-US
To:     "Konstantin Meskhidze (A)" <konstantin.meskhidze@huawei.com>,
        =?UTF-8?Q?G=c3=bcnther_Noack?= <gnoack3000@gmail.com>
Cc:     linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-fsdevel@vger.kernel.org,
        anton Sirazetdinov <anton.sirazetdinov@huawei.com>
References: <20220817203006.21769-1-gnoack3000@gmail.com>
 <20220817203006.21769-3-gnoack3000@gmail.com>
 <e90aaa5d-d6c8-838a-db29-868a30fd8e37@digikod.net> <Yv8elmJ4qfk8/Mw7@nuc>
 <86b013ed-b809-f533-5764-60b22272dce9@digikod.net>
 <2e7afd64-d36f-f81d-2ae4-1a99769e173c@digikod.net>
 <a8670f06-83ea-2a72-f13d-ac9f839dd1f8@huawei.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <a8670f06-83ea-2a72-f13d-ac9f839dd1f8@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>


On 19/08/2022 10:55, Konstantin Meskhidze (A) wrote:
> 
> 
> 8/19/2022 11:36 AM, Mickaël Salaün пишет:
>> FYI, my -next branch is here:
>> https://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git/log/?h=next
>>
>> Günther, let me know if everything is OK.
>>
>> Konstantin, please rebase your work on it. It should mainly conflict
>> with changes related to the Landlock ABI version.
> 
>     Ok. I will rebase. Thnaks. Do I need to keep my next versions on your
> -next branch?

Yes please.
