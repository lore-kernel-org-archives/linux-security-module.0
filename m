Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ABA7E748E9
	for <linux-security-module@archiver.kernel.org>; Sun,  1 Oct 2023 11:08:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234873AbjJALIq (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 1 Oct 2023 07:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234890AbjJALIp (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 1 Oct 2023 07:08:45 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 779A2BD;
        Sun,  1 Oct 2023 04:08:43 -0700 (PDT)
Received: from fsav116.sakura.ne.jp (fsav116.sakura.ne.jp [27.133.134.243])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 391B8VAk066794;
        Sun, 1 Oct 2023 20:08:31 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav116.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav116.sakura.ne.jp);
 Sun, 01 Oct 2023 20:08:31 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav116.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 391B8VEH066791
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 1 Oct 2023 20:08:31 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <153e7c39-d2e2-db31-68cd-cb05eb2d46db@I-love.SAKURA.ne.jp>
Date:   Sun, 1 Oct 2023 20:08:30 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RFC PATCH 1/2] LSM: Allow dynamically appendable LSM modules.
Content-Language: en-US
To:     KP Singh <kpsingh@kernel.org>
Cc:     linux-security-module <linux-security-module@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Paul Moore <paul@paul-moore.com>, bpf <bpf@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <cc8e16bb-5083-01da-4a77-d251a76dc8ff@I-love.SAKURA.ne.jp>
 <CACYkzJ5k7oYxFgWp9bz1Wmp3n6LcU39Mh-HXFWTKnZnpY-Ef7w@mail.gmail.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <CACYkzJ5k7oYxFgWp9bz1Wmp3n6LcU39Mh-HXFWTKnZnpY-Ef7w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 2023/09/28 1:02, KP Singh wrote:
>> Question for KP Singh would be how can we allow dynamically appendable
>> LSM modules if current linked list is replaced with static calls with
>> minimal-sized array...
> 
> As I suggested in the other thread:
> 
> https://lore.kernel.org/bpf/20230918212459.1937798-1-kpsingh@kernel.org/T/#md21b9d9cc769f39e451d20364857b693d3fcb587
> 
> You can add extra static call slots and fallback to a linked list
> based implementation if you have more than say N modules [1] and
> fallback to a linked list implementation [2].

As I explained in the other thread:

https://lkml.kernel.org/r/c1683052-aa5a-e0d5-25ae-40316273ed1b@I-love.SAKURA.ne.jp

build-time configuration does not help at all.

> 
> for [1] you can just do MAX_LSM_COUNT you can just do:
> 
> #ifdef CONFIG_MODULAR_LSM
> #define MODULAR_LSM_ENABLED "1,1,1,1"
> #endif
> 
> and use it in the LSM_COUNT.
> 
> for [2] you can choose to export a better module API than directly
> exposing security_hook_heads.
> 
> Now, comes the question of whether we need dynamically loaded LSMs, I
> am not in favor of this. Please share your limitations of BPF as you
> mentioned and what's missing to implement dynamic LSMs. My question
> still remains unanswered.
> 
> Until I hear the real limitations of using BPF, it's a NAK from me.

Simple questions that TOMOYO/AKARI/CaitSith LSMs depend:

  Q1: How can the BPF allow allocating permanent memory (e.g. kmalloc()) that remains
      the lifetime of the kernel (e.g. before starting the global init process till
      the content of RAM is lost by stopping electric power supply) ?

  Q2: How can the BPF allow interacting with other process (e.g. inter process communication
      using read()/write()) which involves opening some file on the filesystem and sleeping
      for arbitrary duration?



>>  struct security_hook_heads security_hook_heads __ro_after_init;
>> +EXPORT_SYMBOL_GPL(security_hook_heads);
> 
> Rather than exposting security_hook_heads, this should actually export
> security_hook_module_register. This should internally handle any data
> structures used and also not need the special magic that you did for
> __ro_after_init.

I'm fine if security_hook_module_register() (and related code) cannot be
disabled by the kernel configuration.

