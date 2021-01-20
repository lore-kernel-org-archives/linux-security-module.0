Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ED8AC433E6
	for <linux-security-module@archiver.kernel.org>; Thu, 21 Jan 2021 00:13:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C05723730
	for <linux-security-module@archiver.kernel.org>; Thu, 21 Jan 2021 00:13:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbhAUAMd (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 20 Jan 2021 19:12:33 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:33938 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404183AbhATX0C (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 20 Jan 2021 18:26:02 -0500
Received: from [50.53.41.238] (helo=[192.168.192.153])
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <john.johansen@canonical.com>)
        id 1l2MXc-0008Js-VE; Wed, 20 Jan 2021 23:05:33 +0000
Subject: Re: [RFC][PATCH] apparmor: Enforce progressively tighter permissions
 for no_new_privs
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-security-module@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Kees Cook <keescook@chromium.org>,
        James Morris <james.l.morris@oracle.com>,
        apparmor@lists.ubuntu.com, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        James Morris <jmorris@namei.org>
References: <87lfcn5mfz.fsf@x220.int.ebiederm.org>
 <c887b7f1-7c50-cd9d-fd97-b89274c2765c@canonical.com>
 <878s8n43qn.fsf@x220.int.ebiederm.org>
From:   John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; prefer-encrypt=mutual; keydata=
 LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tCgptUUlOQkU1bXJQb0JFQURB
 azE5UHNnVmdCS2tJbW1SMmlzUFE2bzdLSmhUVEtqSmR3VmJrV1NuTm4rbzZVcDVrCm5LUDFm
 NDlFQlFsY2VXZzF5cC9Od2JSOGFkK2VTRU8vdW1hL0srUHFXdkJwdEtDOVNXRDk3Rkc0dUI0
 L2Nhb20KTEVVOTdzTFFNdG52R1dkeHJ4VlJHTTRhbnpXWU1neno1VFptSWlWVFo0M091NVZw
 YVMxVnoxWlN4UDNoL3hLTgpaci9UY1c1V1FhaTh1M1BXVm5ia2poU1pQSHYxQmdoTjY5cXhF
 UG9tckpCbTFnbXR4M1ppVm1GWGx1d1RtVGdKCk9rcEZvbDduYkowaWxuWUhyQTdTWDNDdFIx
 dXBlVXBNYS9XSWFuVk85NldkVGpISElhNDNmYmhtUXViZTR0eFMKM0ZjUUxPSlZxUXN4NmxF
 OUI3cUFwcG05aFExMHFQV3dkZlB5LyswVzZBV3ROdTVBU2lHVkNJbld6bDJIQnFZZAovWmxs
 OTN6VXErTklvQ244c0RBTTlpSCt3dGFHRGNKeXdJR0luK2VkS050SzcyQU1nQ2hUZy9qMVpv
 V0g2WmVXClBqdVVmdWJWelp0bzFGTW9HSi9TRjRNbWRRRzFpUU50ZjRzRlpiRWdYdXk5Y0dp
 MmJvbUYwenZ5QkpTQU5weGwKS05CRFlLek42S3owOUhVQWtqbEZNTmdvbUwvY2pxZ0FCdEF4
 NTlMK2RWSVpmYUYyODFwSWNVWnp3dmg1K0pvRwplT1c1dUJTTWJFN0wzOG5zem9veWtJSjVY
 ckFjaGtKeE5mejdrK0ZuUWVLRWtOekVkMkxXYzNRRjRCUVpZUlQ2ClBISGdhM1JneWtXNSsx
 d1RNcUpJTGRtdGFQYlhyRjNGdm5WMExSUGN2NHhLeDdCM2ZHbTd5Z2Rvb3dBUkFRQUIKdEIx
 S2IyaHVJRXB2YUdGdWMyVnVJRHhxYjJodVFHcHFiWGd1Ym1WMFBva0NPZ1FUQVFvQUpBSWJB
 d1VMQ1FnSApBd1VWQ2drSUN3VVdBZ01CQUFJZUFRSVhnQVVDVG8wWVZ3SVpBUUFLQ1JBRkx6
 WndHTlhEMkx4SkQvOVRKWkNwCndsbmNUZ1llcmFFTWVEZmtXdjhjMUlzTTFqMEFtRTRWdEwr
 ZkU3ODBaVlA5Z2tqZ2tkWVN4dDdlY0VUUFRLTWEKWlNpc3JsMVJ3cVUwb29nWGRYUVNweHJH
 SDAxaWN1LzJuMGpjWVNxWUtnZ1B4eTc4QkdzMkxacTRYUGZKVFptSApaR25YR3EvZURyL21T
 bmowYWF2QkptTVo2amJpUHo2eUh0QllQWjlmZG84YnRjendQNDFZZVdvSXUyNi84SUk2CmYw
 WG0zVkM1b0FhOHY3UmQrUldaYThUTXdsaHpIRXh4ZWwzanRJN0l6ek9zbm1FOS84RG0wQVJE
 NWlUTENYd1IKMWN3SS9KOUJGL1MxWHY4UE4xaHVUM0l0Q05kYXRncDh6cW9Ka2dQVmptdnlM
 NjRRM2ZFa1liZkhPV3NhYmE5LwprQVZ0Qk56OVJURmg3SUhEZkVDVmFUb3VqQmQ3QnRQcXIr
 cUlqV0ZhZEpEM0k1ZUxDVkp2VnJyb2xyQ0FUbEZ0Ck4zWWtRczZKbjFBaUlWSVUzYkhSOEdq
 ZXZnejVMbDZTQ0dIZ1Jya3lScG5TWWFVL3VMZ24zN042QVl4aS9RQUwKK2J5M0N5RUZManpX
 QUV2eVE4YnEzSXVjbjdKRWJoUy9KLy9kVXFMb2VVZjh0c0dpMDB6bXJJVFpZZUZZQVJoUQpN
 dHNmaXpJclZEdHoxaVBmL1pNcDVnUkJuaXlqcFhuMTMxY20zTTNndjZIclFzQUdubjhBSnJ1
 OEdEaTVYSllJCmNvLzEreC9xRWlOMm5DbGFBT3BiaHpOMmVVdlBEWTVXMHEzYkEvWnAybWZH
 NTJ2YlJJK3RRMEJyMUhkL3ZzbnQKVUhPOTAzbU1aZXAyTnpOM0JaNXFFdlB2RzRyVzVacTJE
 cHliV2JRclNtOW9iaUJLYjJoaGJuTmxiaUE4YW05bwpiaTVxYjJoaGJuTmxia0JqWVc1dmJt
 bGpZV3d1WTI5dFBva0NOd1FUQVFvQUlRVUNUbzBYV2dJYkF3VUxDUWdICkF3VVZDZ2tJQ3dV
 V0FnTUJBQUllQVFJWGdBQUtDUkFGTHpad0dOWEQySXRNRC85anliYzg3ZE00dUFIazZ5Tk0K
 TjBZL0JGbW10VFdWc09CaHFPbm9iNGkzOEJyRE8yQzFoUUNQQ1FlNExMczEvNHB0ZW92UXQ4
 QjJGeXJQVmp3Zwo3alpUSE5LNzRyNmxDQ1Z4eDN5dTFCN1U5UG80VlRrY3NsVmIxL3FtV3V4
 OFhXY040eXZrVHFsTCtHeHB5Sm45CjlaWmZmWEpjNk9oNlRtT2ZiS0d2TXV1djVhclNJQTNK
 SEZMZjlhTHZadEExaXNKVXI3cFM5YXBnOXVUVUdVcDcKd2ZWMFdUNlQzZUczbXRVVTJ1cDVK
 VjQ4NTBMMDVqSFM2dVdpZS9ZK3lmSk9iaXlyeE4vNlpxVzVHb25oTEJxLwptc3pjVjV2QlQz
 QkRWZTNSdkY2WGRNOU9oUG4xK1k4MXg1NCt2UTExM044aUx3RjdHR2ExNFp5SVZBTlpEMEkw
 CkhqUnZhMmsvUnFJUlR6S3l1UEg1cGtsY0tIVlBFRk1tT3pNVCtGT294Tmp2Uys3K3dHMktN
 RFlFbUhQcjFQSkIKWlNaZUh6SzE5dGZhbFBNcHBGeGkrc3lZTGFnTjBtQjdKSFF3WTdjclV1
 T0RoeWNxNjBZVnoxdGFFeWd1M1l2MgoyL0kxRUNHSHZLSEc2d2M5MG80M0MvZWxIRUNYbkVo
 N3RLcGxEY3BJQytPQ21NeEtIaFI0NitYY1p2Z3c0RGdiCjdjYTgzZVFSM0NHODlMdlFwVzJM
 TEtFRUJEajdoWmhrTGJra1BSWm0zdzhKWTQ0YXc4VnRneFdkblNFTUNMeEwKSU9OaDZ1Wjcv
 L0RZVnRjSWFNSllrZWJhWnRHZENwMElnVVpiMjQvVmR2WkNZYk82MkhrLzNWbzFuWHdIVUVz
 Mwo2RC92MWJUMFJaRmk2OUxnc0NjT2N4NGdZTGtDRFFST1pxejZBUkFBb3F3NmtrQmhXeU0x
 ZnZnYW1BVmplWjZuCktFZm5SV2JrQzk0TDFFc0pMdXAzV2IyWDBBQk5PSFNrYlNENHBBdUMy
 dEtGL0VHQnQ1Q1A3UWRWS1JHY1F6QWQKNmIyYzFJZHk5Ukx3Nnc0Z2krbm4vZDFQbTFra1lo
 a1NpNXpXYUlnMG01UlFVaytFbDh6a2Y1dGNFLzFOMFo1TwpLMkpoandGdTViWDBhMGw0Y0ZH
 V1ZRRWNpVk1ES1J0eE1qRXRrM1N4RmFsbTZaZFEycHAyODIyY2xucTR6WjltCld1MWQyd2F4
 aXorYjVJYTR3ZURZYTduNDFVUmNCRVViSkFnbmljSmtKdENUd3lJeElXMktuVnlPcmp2a1F6
 SUIKdmFQMEZkUDJ2dlpvUE1kbENJek9sSWtQTGd4RTBJV3VlVFhlQkpoTnMwMXBiOGJMcW1U
 SU1sdTRMdkJFTEEvdgplaWFqajVzOHk1NDJIL2FIc2ZCZjRNUVVoSHhPL0JaVjdoMDZLU1Vm
 SWFZN09nQWdLdUdOQjNVaWFJVVM1K2E5CmduRU9RTER4S1J5L2E3UTF2OVMrTnZ4KzdqOGlI
 M2prUUpoeFQ2WkJoWkdSeDBna0gzVCtGMG5ORG01TmFKVXMKYXN3Z0pycUZaa1VHZDJNcm0x
 cW5Ld1hpQXQ4U0ljRU5kcTMzUjBLS0tSQzgwWGd3ajhKbjMwdlhMU0crTk8xRwpIMFVNY0F4
 TXd5L3B2azZMVTVKR2paUjczSjVVTFZoSDRNTGJEZ2dEM21QYWlHOCtmb3RUckpVUHFxaGc5
 aHlVCkVQcFlHN3NxdDc0WG43OStDRVpjakxIenlsNnZBRkUyVzBreGxMdFF0VVpVSE8zNmFm
 RnY4cUdwTzNacVB2akIKVXVhdFhGNnR2VVFDd2YzSDZYTUFFUUVBQVlrQ0h3UVlBUW9BQ1FV
 Q1RtYXMrZ0liREFBS0NSQUZMelp3R05YRAoyRC9YRC8wZGRNLzRhaTFiK1RsMWp6bkthalgz
 a0crTWVFWWVJNGY0MHZjbzNyT0xyblJHRk9jYnl5ZlZGNjlNCktlcGllNE93b0kxamNUVTBB
 RGVjbmJXbkROSHByMFNjenhCTXJvM2Juckxoc212anVuVFlJdnNzQlp0QjRhVkoKanVMSUxQ
 VWxuaEZxYTdmYlZxMFpRamJpVi9ydDJqQkVOZG05cGJKWjZHam5wWUljQWJQQ0NhL2ZmTDQv
 U1FSUwpZSFhvaEdpaVM0eTVqQlRtSzVsdGZld0xPdzAyZmtleEgrSUpGcnJHQlhEU2c2bjJT
 Z3hubisrTkYzNGZYY205CnBpYXczbUtzSUNtKzBoZE5oNGFmR1o2SVdWOFBHMnRlb29WRHA0
 ZFlpaCsreFgvWFM4ekJDYzFPOXc0bnpsUDIKZ0t6bHFTV2JoaVdwaWZSSkJGYTRXdEFlSlRk
 WFlkMzdqL0JJNFJXV2hueXc3YUFQTkdqMzN5dEdITlVmNlJvMgovanRqNHRGMXkvUUZYcWpK
 Ry93R2pwZHRSZmJ0VWpxTEhJc3ZmUE5OSnEvOTU4cDc0bmRBQ2lkbFdTSHpqK09wCjI2S3Bi
 Rm5td05PMHBzaVVzbmh2SEZ3UE8vdkFibDNSc1I1KzBSbytodnMyY0VtUXV2OXIvYkRsQ2Zw
 enAydDMKY0srcmh4VXFpc094OERaZnoxQm5rYW9DUkZidnZ2ays3TC9mb21QbnRHUGtxSmNp
 WUU4VEdIa1p3MWhPa3UrNApPb00yR0I1bkVEbGorMlRGL2pMUStFaXBYOVBrUEpZdnhmUmxD
 NmRLOFBLS2ZYOUtkZm1BSWNnSGZuVjFqU24rCjh5SDJkakJQdEtpcVcwSjY5YUlzeXg3aVYv
 MDNwYVBDakpoN1hxOXZBenlkTjVVL1VBPT0KPTZQL2IKLS0tLS1FTkQgUEdQIFBVQkxJQyBL
 RVkgQkxPQ0stLS0tLQo=
Organization: Canonical
Message-ID: <3ccb2c45-2836-bce5-3cb3-0320e66b9656@canonical.com>
Date:   Wed, 20 Jan 2021 15:05:25 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <878s8n43qn.fsf@x220.int.ebiederm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 1/20/21 2:56 PM, Eric W. Biederman wrote:
> 
> TL;DR ????selinux and apparmor ignore no_new_privs????
> 
> What?????
> 

AppArmor does not ignore no_new_privs. Its mediation is bounded
and it doesn't grant anything that wasn't allowed when NNP was
set.


> 
> John Johansen <john.johansen@canonical.com> writes:
> 
>> On 1/20/21 1:26 PM, Eric W. Biederman wrote:
>>>
>>> The current understanding of apparmor with respect to no_new_privs is at
>>> odds with how no_new_privs is implemented and understood by the rest of
>>> the kernel.
>>>
>>> The documentation of no_new_privs states:
>>>> With ``no_new_privs`` set, ``execve()`` promises not to grant the
>>>> privilege to do anything that could not have been done without the
>>>> execve call.
>>>
>>> And reading through the kernel except for apparmor that description
>>> matches what is implemented.
>>>
>>
>> That is not correct.
>>
>> commit 7b0d0b40cd78 ("selinux: Permit bounded transitions under
>>     NO_NEW_PRIVS or NOSUID.")
>>
>> Allows for bound transitions under selinux
>> and
> 
> As I understand a bound transition it is a transition to a state with
> a set of permissions that are a subset of what was previously held.
> Which is consistent with the mandate of no_new_privs.
> 
>> commit af63f4193f9f selinux: Generalize support for NNP/nosuid SELinux
>>     domain transitions
>>
>> goes further and "Decouple NNP/nosuid from SELinux transitions".
> 
> Yes.  Looking at that commit I do see that selinux appears to be
> deliberately ignoring no_new_privs in specific cases.
> 
> WTF.
> 
>>> There are two major divergences of apparmor from this definition:
>>> - proc_setattr enforces limitations when no_new_privs are set.
>>> - the limitation is enforced from the apparent time when no_new_privs is
>>>   set instead of guaranteeing that each execve has progressively more
>>>   narrow permissions.
>>>
>>> The code in apparmor that attempts to discover the apparmor label at the
>>> point where no_new_privs is set is not robust.  The capture happens a
>>> long time after no_new_privs is set.
>>>
>>
>> yes, but that shouldn't matter. As apparmor has not changed its label
>> at any point between when no_new_privs was set and when the check is
>> done. AppArmor is attempting to change it label, and if it finds NNP
>> has been set we capture what the confinement was.
>>
>>> Capturing the label at the point where no_new_privs is set is
>>> practically impossible to implement robustly.  Today the rule is struct
>>> cred can only be changed by it's current task.  Today
>>
>> right, and apparmor only ever has the task update its own label.
>>
>>> SECCOMP_FILTER_FLAG_TSYNC sets no_new_privs from another thread.  A
>>> robust implementation would require changing something fundamental in
>>> how creds are managed for SECCOMP_FILTER_FLAG_TSYNC to be able to
>>> capture the cred at the point it is set.
>>>
>> I am open to supporting something like that.
> 
> I can't see how it would be possible to be robust without completely
> changing the locking.  Locking that right now in a simpler model we have
> not figured out how to make obviously correct.
> 
>>> Futhermore given the consistent documentation and how everything else
>>> implements no_new_privs, not having the permissions get progressively
>>
>> Again see above
> 
> Except where selinux deliberately ignores no_new_privs this is
> consitent.
> 
>>> tighter is a footgun aimed at userspace.  I fully expect it to break any
>>
>> tighter is somewhat relative, nor is it only progressively tighter it
>> is bounded against the snapshot of the label that was on the task.
> 
> Which is the BUG I am reporting.  It should be progressingly tighter.
> 
>>> security sensitive software that uses no_new_privs and was not
>>> deliberately designed and tested against apparmor.
>>>
>>
>> Currently the situation has become either an either or choice between
>> the LSM and NNP. We are trying to walk a balance. Ideally apparmor
>> would like to do something similar to selinux and decouple the label
>> transition from NNP and nosuid via an internal capability, but we
>> have not gone there yet.
> 
> Why do you need to escape no_new_privs.  Why does anyone need to escape
> no_new_privs?
> 
>>> Avoid the questionable and hard to fix implementation and the
>>> potential to confuse userspace by having no_new_privs enforce
>>> progressinvely tighter permissions.
>>>
>>
>> This would completely break several use cases.
> 
> Enforcing no_new_privs as documented would break userspace?
> 
> Isn't the opposite true that you are breaking people by not enforcing
> it?
> 
>>> Fixes: 9fcf78cca198 ("apparmor: update domain transitions that are subsets of confinement at nnp")
>>> Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
>>> ---
>>>
>>> I came accross this while examining the places cred_guard_mutex is
>>> used and trying to find a way to make those code paths less insane.
>>>
>>> If it would be more pallatable I would not mind removing the
>>> task_no_new_privs test entirely from aa_change_hat and aa_change_profile
>>> as those are not part of exec, so arguably no_new_privs should not care
>>> about them at all.
>>>
>>> Can we please get rid of the huge semantic wart and pain in the implementation?
>>>
>>>  security/apparmor/domain.c       | 39 ++++----------------------------
>>>  security/apparmor/include/task.h |  4 ----
>>>  security/apparmor/task.c         |  7 ------
>>>  3 files changed, 4 insertions(+), 46 deletions(-)
>>>
>>> diff --git a/security/apparmor/domain.c b/security/apparmor/domain.c
>>> index f919ebd042fd..8f77059bf890 100644
>>> --- a/security/apparmor/domain.c
>>> +++ b/security/apparmor/domain.c
>>> @@ -869,17 +869,6 @@ int apparmor_bprm_creds_for_exec(struct linux_binprm *bprm)
>>>  
>>>  	label = aa_get_newest_label(cred_label(bprm->cred));
>>>  
>>> -	/*
>>> -	 * Detect no new privs being set, and store the label it
>>> -	 * occurred under. Ideally this would happen when nnp
>>> -	 * is set but there isn't a good way to do that yet.
>>> -	 *
>>> -	 * Testing for unconfined must be done before the subset test
>>> -	 */
>>> -	if ((bprm->unsafe & LSM_UNSAFE_NO_NEW_PRIVS) && !unconfined(label) &&
>>> -	    !ctx->nnp)
>>> -		ctx->nnp = aa_get_label(label);
>>> -
>>>  	/* buffer freed below, name is pointer into buffer */
>>>  	buffer = aa_get_buffer(false);
>>>  	if (!buffer) {
>>> @@ -915,7 +904,7 @@ int apparmor_bprm_creds_for_exec(struct linux_binprm *bprm)
>>>  	 */
>>>  	if ((bprm->unsafe & LSM_UNSAFE_NO_NEW_PRIVS) &&
>>>  	    !unconfined(label) &&
>>> -	    !aa_label_is_unconfined_subset(new, ctx->nnp)) {
>>> +	    !aa_label_is_unconfined_subset(new, label)) {
>>>  		error = -EPERM;
>>>  		info = "no new privs";
>>>  		goto audit;
>>> @@ -1158,16 +1147,6 @@ int aa_change_hat(const char *hats[], int count, u64 token, int flags)
>>>  	label = aa_get_newest_cred_label(cred);
>>>  	previous = aa_get_newest_label(ctx->previous);
>>>  
>>> -	/*
>>> -	 * Detect no new privs being set, and store the label it
>>> -	 * occurred under. Ideally this would happen when nnp
>>> -	 * is set but there isn't a good way to do that yet.
>>> -	 *
>>> -	 * Testing for unconfined must be done before the subset test
>>> -	 */
>>> -	if (task_no_new_privs(current) && !unconfined(label) && !ctx->nnp)
>>> -		ctx->nnp = aa_get_label(label);
>>> -
>>>  	if (unconfined(label)) {
>>>  		info = "unconfined can not change_hat";
>>>  		error = -EPERM;
>>> @@ -1193,7 +1172,7 @@ int aa_change_hat(const char *hats[], int count, u64 token, int flags)
>>>  		 * reduce restrictions.
>>>  		 */
>>>  		if (task_no_new_privs(current) && !unconfined(label) &&
>>> -		    !aa_label_is_unconfined_subset(new, ctx->nnp)) {
>>> +		    !aa_label_is_unconfined_subset(new, label)) {
>>>  			/* not an apparmor denial per se, so don't log it */
>>>  			AA_DEBUG("no_new_privs - change_hat denied");
>>>  			error = -EPERM;
>>> @@ -1214,7 +1193,7 @@ int aa_change_hat(const char *hats[], int count, u64 token, int flags)
>>>  		 * reduce restrictions.
>>>  		 */
>>>  		if (task_no_new_privs(current) && !unconfined(label) &&
>>> -		    !aa_label_is_unconfined_subset(previous, ctx->nnp)) {
>>> +		    !aa_label_is_unconfined_subset(previous, label)) {
>>>  			/* not an apparmor denial per se, so don't log it */
>>>  			AA_DEBUG("no_new_privs - change_hat denied");
>>>  			error = -EPERM;
>>> @@ -1303,16 +1282,6 @@ int aa_change_profile(const char *fqname, int flags)
>>>  
>>>  	label = aa_get_current_label();
>>>  
>>> -	/*
>>> -	 * Detect no new privs being set, and store the label it
>>> -	 * occurred under. Ideally this would happen when nnp
>>> -	 * is set but there isn't a good way to do that yet.
>>> -	 *
>>> -	 * Testing for unconfined must be done before the subset test
>>> -	 */
>>> -	if (task_no_new_privs(current) && !unconfined(label) && !ctx->nnp)
>>> -		ctx->nnp = aa_get_label(label);
>>> -
>>>  	if (!fqname || !*fqname) {
>>>  		aa_put_label(label);
>>>  		AA_DEBUG("no profile name");
>>> @@ -1409,7 +1378,7 @@ int aa_change_profile(const char *fqname, int flags)
>>>  		 * reduce restrictions.
>>>  		 */
>>>  		if (task_no_new_privs(current) && !unconfined(label) &&
>>> -		    !aa_label_is_unconfined_subset(new, ctx->nnp)) {
>>> +		    !aa_label_is_unconfined_subset(new, label)) {
>>>  			/* not an apparmor denial per se, so don't log it */
>>>  			AA_DEBUG("no_new_privs - change_hat denied");
>>>  			error = -EPERM;
>>> diff --git a/security/apparmor/include/task.h b/security/apparmor/include/task.h
>>> index f13d12373b25..8a9c258e2018 100644
>>> --- a/security/apparmor/include/task.h
>>> +++ b/security/apparmor/include/task.h
>>> @@ -17,13 +17,11 @@ static inline struct aa_task_ctx *task_ctx(struct task_struct *task)
>>>  
>>>  /*
>>>   * struct aa_task_ctx - information for current task label change
>>> - * @nnp: snapshot of label at time of no_new_privs
>>>   * @onexec: profile to transition to on next exec  (MAY BE NULL)
>>>   * @previous: profile the task may return to     (MAY BE NULL)
>>>   * @token: magic value the task must know for returning to @previous_profile
>>>   */
>>>  struct aa_task_ctx {
>>> -	struct aa_label *nnp;
>>>  	struct aa_label *onexec;
>>>  	struct aa_label *previous;
>>>  	u64 token;
>>> @@ -42,7 +40,6 @@ struct aa_label *aa_get_task_label(struct task_struct *task);
>>>  static inline void aa_free_task_ctx(struct aa_task_ctx *ctx)
>>>  {
>>>  	if (ctx) {
>>> -		aa_put_label(ctx->nnp);
>>>  		aa_put_label(ctx->previous);
>>>  		aa_put_label(ctx->onexec);
>>>  	}
>>> @@ -57,7 +54,6 @@ static inline void aa_dup_task_ctx(struct aa_task_ctx *new,
>>>  				   const struct aa_task_ctx *old)
>>>  {
>>>  	*new = *old;
>>> -	aa_get_label(new->nnp);
>>>  	aa_get_label(new->previous);
>>>  	aa_get_label(new->onexec);
>>>  }
>>> diff --git a/security/apparmor/task.c b/security/apparmor/task.c
>>> index d17130ee6795..4b9ec370a171 100644
>>> --- a/security/apparmor/task.c
>>> +++ b/security/apparmor/task.c
>>> @@ -41,7 +41,6 @@ struct aa_label *aa_get_task_label(struct task_struct *task)
>>>  int aa_replace_current_label(struct aa_label *label)
>>>  {
>>>  	struct aa_label *old = aa_current_raw_label();
>>> -	struct aa_task_ctx *ctx = task_ctx(current);
>>>  	struct cred *new;
>>>  
>>>  	AA_BUG(!label);
>>> @@ -56,12 +55,6 @@ int aa_replace_current_label(struct aa_label *label)
>>>  	if (!new)
>>>  		return -ENOMEM;
>>>  
>>> -	if (ctx->nnp && label_is_stale(ctx->nnp)) {
>>> -		struct aa_label *tmp = ctx->nnp;
>>> -
>>> -		ctx->nnp = aa_get_newest_label(tmp);
>>> -		aa_put_label(tmp);
>>> -	}
>>>  	if (unconfined(label) || (labels_ns(old) != labels_ns(label)))
>>>  		/*
>>>  		 * if switching to unconfined or a different label namespace
>>>
> 
> Eric
> 

