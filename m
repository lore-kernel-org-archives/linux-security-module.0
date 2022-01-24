Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A35DEC433EF
	for <linux-security-module@archiver.kernel.org>; Tue, 25 Jan 2022 03:44:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356636AbiAYDmR (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 24 Jan 2022 22:42:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387595AbiAYAFB (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 24 Jan 2022 19:05:01 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C99BFC06175E
        for <linux-security-module@vger.kernel.org>; Mon, 24 Jan 2022 13:51:43 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id r6so250058wma.0
        for <linux-security-module@vger.kernel.org>; Mon, 24 Jan 2022 13:51:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=srr/mrE9ehQhNYn9l/3n/EiUiL51nAi3+Ry/bc/qsPs=;
        b=LECvdqw9MpqWi9TFdn/2hlf5iwfK0tTITghIYoS9mCKEfo6HCp3KL3b3+65iCj3iLa
         zrjzVPUPAIPLzjrLfqEFSaatMyUH2RkcjFK+ca8L+Qv3eUl8x1guw3XOkuOzm/B9DE1q
         fsUkebTrEN0djt3xCCYsjvXwEnz0aLdLYEI4sJEyZsmPvSsOdUFUJJAdqlr16A/u3aIf
         ECf50IDf76UDLgpjf8NHob+Qv3Ut0najj6IYJ/eo+ksRFi7ziwArzujvhKjk27qQmuyY
         SfpyePcrRokzYhWNfl0kLgjLa1Krht/krH3qhcKXuRMklqYzwBczc+qOrg+8fXNa+U5i
         /Oow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=srr/mrE9ehQhNYn9l/3n/EiUiL51nAi3+Ry/bc/qsPs=;
        b=BtURN9DlaJ9gvyDTQz2nYuSTwbncd4+rTKcq/smql2qN/fL/PTujxZDRsepVuGM7GG
         OEjDXrDNPOee7VhnIic0a9Uot6QWxsR+MsBghtDPt+P5ntZYFqkymvU/uQs/6JPrqt4r
         czLlFqb26RAXyoPN8eNOFTcyGaDw+/CnFeQa5PeJJiP+wiY0LSW3s1jivpCmPXxlNCuO
         osrQxJK5xbAhWzlmh7sgO4gQ/ScElRWPIBjG3i1QRMRTqy4YJExSOcQ5dxDth2CYUnCI
         9grcO5btjW/IOE+j94j9JCN+m783PwIqgFIoq+UMFnXs1YSrpI48NIFmCZ3LeuNtfJT2
         insQ==
X-Gm-Message-State: AOAM530LIqufak3/bgFA18Jtc+aYjqX7fQcLv2oSexy0sj04vesC/HK3
        5e6yQHB5w9CDVp0C274R85pKsmUwcs8=
X-Google-Smtp-Source: ABdhPJz+Yp4pRwbE+XeigpdtjzEBf2kJdZElj9bjDUNQxJ0MI/L7PfWCHdT7trjC4LZOwPXhOhQArA==
X-Received: by 2002:a05:600c:204b:: with SMTP id p11mr244769wmg.47.1643061102179;
        Mon, 24 Jan 2022 13:51:42 -0800 (PST)
Received: from [192.168.1.164] (mue-88-130-56-160.dsl.tropolys.de. [88.130.56.160])
        by smtp.gmail.com with ESMTPSA id 10sm439882wmc.44.2022.01.24.13.51.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jan 2022 13:51:41 -0800 (PST)
Message-ID: <9db2a56a-2663-41bf-caf3-5fef2ef7c577@gmail.com>
Date:   Mon, 24 Jan 2022 22:51:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: Custom LSM: getting a null pointer dereference when trying to
 access a task security blob
Content-Language: en-US
To:     Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module@vger.kernel.org
References: <c4cbfdb3-f904-b587-d407-268650e6565d@gmail.com>
 <028166ec-0921-977e-8990-4134b5920cad@schaufler-ca.com>
 <882d62bb-1cc2-0019-cc8c-cdacea31e8d3@gmail.com>
 <15530231-a608-8299-7dd1-a8b0155e5e29@gmail.com>
 <82883631-9eb1-2660-afe3-e7308ef1ed45@schaufler-ca.com>
From:   Denis Obrezkov <denisobrezkov@gmail.com>
In-Reply-To: <82883631-9eb1-2660-afe3-e7308ef1ed45@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>


> 
> I'm curious about the value provided by KeyLock.
> 

disclaimer: it's mostly for educational purposes, a part of my phd studies.

The main idea behind KeyLock is to be intuitive for an end-user. So, a
user should be able to attach "lock" labels to files (objects). A file
security context might look like: "label1(rw), label2(wx)"
Also, a user should be able to attach "key" labels to tasks (subjects).
So, the context of a task might look: "label5(r), label2(xt)"

A subject will have access to an object if it has all the keys for all
the locks:
       Task (subj)     |     File (obj)         | Access provided
-----------------------------------------------------------------------
 lbl1(rw),lbl2(rx)     |    lbl1(rwx),lbl2(rwx) |  yes: r
 lbl1(rw),lbl2(rwx)    |    lbl1(wx),lbl2(r)    |  no (see masks)
 lbl1(rwx),lbl3(rwx)   |    lbl1(rwx),lbl2(rwx) |  no (no 'lbl2' key)

As you can see, actions like r, w, x are also accounted. So, firstly, in
order to provide access we should:
1. check that all "locks" have corresponding "keys"
2. logically summarize all permissions for each "key-lock" pair:
from the first example above
lbl1(rw) + lbl1(rwx) -> rw
lbl2(rx) + lbl2(rwx) -> rx
rw + rx -> r

So, with that system we can get rig of a rules file. Also, there is a
chance that it would be easier to use for non-IT people.

P.S. I know that it is possible to do similar things in SMACK, but for
educational purposes I decided to implement it in kernel code.

P.P.S. I tried to do it using SELinux and its policy languages but it
was too complicated for me.

-- 
Regards, Denis Obrezkov
