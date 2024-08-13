Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86671BF3A;
	Tue, 13 Aug 2024 04:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723522081; cv=none; b=W2iQnI0Y7gRbNH6DrIovMvg5BWpHCgnWrp6lO15NwihSiSGWoREC1idVlp664RrrCQUuy7yqf617QWmd7ppU7VgW+V75MCEdFsrHo2BPpm7F2b4kSTBxKBb8E38ud/qloE1wVKwBkdc7+BMMZ8xRt9ToJvym0Bqnbb/ni959bes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723522081; c=relaxed/simple;
	bh=0FHwdFo1cbfd/xpppN57qHU6RywVoM+hW6prsLErDjo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SDaGZ8UXTRCTrLkdKwrG/DFGMr1w0pCYfhuJBbHliIpCfYvEo2Z2yCfsNfIBkErUyvVN0Iku20T3hYvICyezi8j/eL0gKjehGH0dv/AFKsQodMGvG5/UfODZTkkD0zRip9Hz9w2hbCaRNlll3Bn61YYrNWdtommntS5eabWx0qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NqmuzGRa; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NqmuzGRa"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-70d1a74a43bso3681830b3a.1;
        Mon, 12 Aug 2024 21:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723522079; x=1724126879; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=6NF2wsA61l1FkXb4eKHpTc6UtfpI/JIOh1marXYcl3w=;
        b=NqmuzGRaNuZJvKshMTav46pGZDxpOoZ+YqPCl31c0Wy+wOFUa/89OQEEMf70/1fcBT
         pxcjourTVxAv4ceJ34hAvp2lQ79PMR3GXWaUvnby2SIMuxIu44FC+Tw3FSHxiz1oyTIz
         5YwsTaNUnmM+skhOMToCMpz9Q8mynP/hYZ1WGXg1PJMO0ROSbfaPBSVEHYWPKyen4gln
         Ugk3/bWlm/MDl3he7PNJoRl1VNDlBnhYS6/xT8qoAARb2GFLmDw6mUwitEEezVYxSc1H
         dhN/ypiP5WmO+J4sIlJYlnaUQ/rSyYT1d1pKGkgtxYkEQS8H8iTc7mNtZJmic8yn//kN
         RuXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723522079; x=1724126879;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6NF2wsA61l1FkXb4eKHpTc6UtfpI/JIOh1marXYcl3w=;
        b=kd52CWXPPeQ+aNgKex7T57RAfSkGjUX8q4MqrskGEMHvbjdYscayXDhA79TDUDAfsw
         Sr3PGoTsss56Im9rJDi2bFA/X3CzgGqWceADAGPpLgUqBmDcXiTb0UpLx5zZvSC86biC
         dEJXnHcAiON/5ZOAznGZahrkYAihQ18OTz5g6yvOrfLKrXSlclIF1Dy72WpGXARsq2Kr
         8+UbIHEgh/6Yb67sQivfs1KxmeROEAmceYOd4VZSb0qk8B63N5O7OUbM6I8nwXcLFdI7
         df1N0KO+TKSpMz18hdQEDvL2UQjJId1xi6/bcpKuuT0yNfCC6WLp61jR3ePzi6fqtQ34
         oLKw==
X-Forwarded-Encrypted: i=1; AJvYcCV2mV7d4SUXOeHbTtxjiaDGHHn2rR2yqYhuZXF4wPS+50kH9Nb/GYfsFzCd36/WdfnXpVdSPtBctByxRz5iYU04KAsR8utzLgxnulKWz/s1+Q6c3wmzp39LnFbsD4EsQ5n4+ziP2Uvx6/Jb1x1WuQGJSTJO
X-Gm-Message-State: AOJu0Yxc58EA/24sjOxAgUIWk3p9w1rBajCBe2CWUULFwsgi7KVBdkc6
	mrFmfqpqhCqrd6fxdb5K3IbvcSla7hG1AL+ziJA0uU+7FNbEKME5
X-Google-Smtp-Source: AGHT+IHj77rGRBe3tmPKEL/+pWD4425i7Jlr9klDhvdctApJeZ2gS4Is/Iz+O9PDZUyvPoiLeBLc5A==
X-Received: by 2002:a05:6a21:3982:b0:1c6:fc56:744 with SMTP id adf61e73a8af0-1c8d754d4e9mr3332488637.31.1723522078920;
        Mon, 12 Aug 2024 21:07:58 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d1c9db74absm9225321a91.42.2024.08.12.21.07.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Aug 2024 21:07:58 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <b3c04f8a-b7e9-4dc7-849e-aeaed508b8cf@roeck-us.net>
Date: Mon, 12 Aug 2024 21:07:56 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] init/main.c: Initialize early LSMs after arch code
To: KP Singh <kpsingh@kernel.org>, Paul Moore <paul@paul-moore.com>
Cc: Nathan Chancellor <nathan@kernel.org>, linux-kernel@vger.kernel.org,
 linux-security-module@vger.kernel.org, bp@alien8.de, sfr@canb.auug.org.au,
 peterz@infradead.org, ink@jurassic.park.msu.ru, richard.henderson@linaro.org
References: <CAHC9VhQpX-nnBd_aKTg7BxaMqTUZ8juHUsQaQbA=hggePMtxcw@mail.gmail.com>
 <873b04da-7a1e-47b9-9cfd-81db5d76644d@roeck-us.net>
 <CAHC9VhTd0MKVXsZ7J_b_Mmr2vP+RMJtxzfsgpH1rZ_hoHY1D3A@mail.gmail.com>
 <779dfb7f-d690-432e-8461-b26935974ac6@roeck-us.net>
 <0673d2b2-ad78-46f4-93b2-73ea3acd70f7@roeck-us.net>
 <CACYkzJ63DRLtDy6DAsGhz8_mM1pUSaC-DjbCtTBtEMP0c-=yRg@mail.gmail.com>
 <d9fc949a-6945-4c41-83de-c3717d536c15@roeck-us.net>
 <CAHC9VhRGt-b8PmtR-hZwOWB1zfmuhfftoppjacqrjq60tm0mag@mail.gmail.com>
 <8061553f-6bfc-4ee6-a8f1-e3741cf5ae6c@roeck-us.net>
 <CAHC9VhSKzxknTgKQu6ODoyxhc3skcjh_h11wSQrEvWb_vP5Ziw@mail.gmail.com>
 <CACYkzJ6NuGQchRaj-QD_XzQWNT8c3zb0ZEBXWjzjAckQdNDCWw@mail.gmail.com>
 <CAHC9VhQjCHBii=CwMMnbs0hiiN-Dy49S+3gpDvaXp-YQyEHTGw@mail.gmail.com>
 <CACYkzJ7vC7OJWdgm6LbOL82eO=27cn7Gh8i6-HOp_A94-SU-gA@mail.gmail.com>
 <CAHC9VhQPHsqnNd2S_jDbWC3LcmXDG1EoaU_Cat8RoxJv3U=_Tg@mail.gmail.com>
 <CACYkzJ5J8K2D8xqT+CCrbvp57P=GbCB+XYXkAaKXojsFhuaWEw@mail.gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <CACYkzJ5J8K2D8xqT+CCrbvp57P=GbCB+XYXkAaKXojsFhuaWEw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/12/24 15:02, KP Singh wrote:
> On Mon, Aug 12, 2024 at 11:33 PM Paul Moore <paul@paul-moore.com> wrote:
>>
>> On Mon, Aug 12, 2024 at 5:14 PM KP Singh <kpsingh@kernel.org> wrote:
>>> On Mon, Aug 12, 2024 at 9:33 PM Paul Moore <paul@paul-moore.com> wrote:
>>>> On Mon, Aug 12, 2024 at 1:12 PM KP Singh <kpsingh@kernel.org> wrote:
>>>>>
>>>>> JFYI, I synced with Guenter and all arch seem to pass and alpha does
>>>>> not work due to a reason that I am unable to debug. I will try doing
>>>>> more debugging but I will need more alpha help here (Added the
>>>>> maintainers to this thread).
>>>>
>>>> Thanks for the update; I was hoping that we might have a resolution
>>>> for the Alpha failure by now but it doesn't look like we're that
>>>> lucky.  Hopefully the Alpha devs will be able to help resolve this
>>>> without too much trouble.
>>>>
>>>> Unfortunately, this does mean that I'm going to drop the static call
>>>> patches from the lsm/dev branch so that we can continue merging other
>>>> things.  Of course this doesn't mean the static call patches can't
>>>> come back in later during this dev cycle once everything is solved if
>>>> there is still time, and worst case there is always the next dev
>>>> cycle.
>>>>
>>>
>>> Do we really want to drop them for alpha? I would rather disable
>>> CONFIG_SECURITY for alpha and if people really care for alpha we can
>>> enable it. Alpha folks, what do you think?
>>
>> Seriously?  I realize Alpha is an older, lesser used arch, but it is
>> still a supported arch and we are not going to cause a regression for
>> the sake of a new feature.  As I mentioned earlier, once the problem
>> is resolved we can bring the patchset back into lsm/dev; if it gets
>> resolved soon enough we can even do it during this dev cycle.
>>
> 
> Okay, more data for the alpha folks, when I moved trap_init() before
> early_security_init() everything seemed to work, I think we might need
> to call trap_init() from setup_arch and this would fix the issue. As
> to why? I don't know :)
> 
> Would alpha folks be okay with this patch:
> 
> kpsingh@kpsingh:~/projects/linux$ git diff
> diff --git a/arch/alpha/kernel/setup.c b/arch/alpha/kernel/setup.c
> index bebdffafaee8..53909c1be4cf 100644
> --- a/arch/alpha/kernel/setup.c
> +++ b/arch/alpha/kernel/setup.c
> @@ -657,6 +657,7 @@ setup_arch(char **cmdline_p)
>          setup_smp();
>   #endif
>          paging_init();
> +       trap_init();
>   }
> 
> 
> and provide me some reason as to why this works, it would be great for
> a patch description
> 

Your code triggers a trap (do_entUna, unaligned access) which isn't handled unless
trap_init() has been called before.

Reason is that static_calls_table is not 8-byte aligned, causing the unaligned
access in:

static void __init lsm_static_call_init(struct security_hook_list *hl)
{
         struct lsm_static_call *scall = hl->scalls;
         int i;

         for (i = 0; i < MAX_LSM_COUNT; i++) {
                 /* Update the first static call that is not used yet */
                 if (!scall->hl) {						<-- here
                         __static_call_update(scall->key, scall->trampoline,
                                              hl->hook.lsm_func_addr);
                         scall->hl = hl;
                         static_branch_enable(scall->active);
                         return;
                 }
                 scall++;
         }
         panic("%s - Ran out of static slots.\n", __func__);
}

A somewhat primitive alternate fix is:

diff --git a/security/security.c b/security/security.c
index aa059d0cfc29..dea9736b2014 100644
--- a/security/security.c
+++ b/security/security.c
@@ -156,7 +156,7 @@ static __initdata struct lsm_info *exclusive;
   * and a trampoline (STATIC_CALL_TRAMP) which are used to call
   * __static_call_update when updating the static call.
   */
-struct lsm_static_calls_table static_calls_table __ro_after_init = {
+struct lsm_static_calls_table static_calls_table __ro_after_init __attribute__((aligned(8))) = {
  #define INIT_LSM_STATIC_CALL(NUM, NAME)                                        \
         (struct lsm_static_call) {                                      \
                 .key = &STATIC_CALL_KEY(LSM_STATIC_CALL(NAME, NUM)),    \

Guenter

