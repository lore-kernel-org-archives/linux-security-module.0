Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD7C1B14F3;
	Thu, 20 Jun 2024 19:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718910230; cv=none; b=djoTH7esIpMHMRzhSakuzlPmc7QCi3JXMk88Repc1zsA6ANhwnRezidd3zF7Rm0zMzxVTE+HCvv0rjDrTW8XWN0DpTbo6WMgcQObchA4y3gXolIG5K4iTGFo7RuhrfFl62qVObMXt+13qnJM7CbuNOh0au5JfuYtkn2pY9XI8m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718910230; c=relaxed/simple;
	bh=R1hYgGLAMnlIS805wLS9PFFaOTvXGqoX3n+F3EUiQ+Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m8QHnTgd0JR1fgl91Or9J/asZmlPpGFPQ09Hrt+dZ1vNhyU9ILoPO/vus3IJT3GAkwhlJBQDUeMCuAE2y1drkWETQrlhbwqsywNeHbIDdSM46QVBJpZHTFieaEitRrO8IfMPZCfbjRBxEphl1knP0M4rPcxQQjugnOO49P2SWcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=X6XGlnfS; arc=none smtp.client-ip=185.125.188.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="X6XGlnfS"
Received: from [10.0.0.100] (pool-99-255-30-7.cpe.net.cable.rogers.com [99.255.30.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id B521A3F1D7;
	Thu, 20 Jun 2024 19:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1718910224;
	bh=eVviGGJ25IZMAT+9QYuehH6Y+a7FEBu2Gx4YWPM6ySM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=X6XGlnfSU31rhJH07DJIFiA+3+Y0Xilh8ekQ0MSDN9ujkv/5aC+Ulss7J6ZJGmNZM
	 +URACISWptp6qYdMXM8Hm30ZbXU+U37dbLo2E+1LTyG/NVqKoFals9E2+uMGNATyEE
	 YJo2F99QLEbn9mW+FznrO6Vk77Y9V86vqb8bOFm3w5ZHXVy2kUB+I4DBs90JVJoUwF
	 Tjdc2VrdAV/UIQhI9aI3rtRlZpKgUwIkOTisXkDKT6OERI9inUcqYJvMBYgXgsq9Dq
	 YRbO6tDeSW5pOFwLTq+h5wXi28IUcbvM4G302oYgDaHlPeW6RDkxCR7imUdLEvB4us
	 oiZSYFElCVVYQ==
Message-ID: <809565c5-e9b0-4783-9079-db27f794d682@canonical.com>
Date: Thu, 20 Jun 2024 12:03:40 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] apparmor: try to avoid refing the label in
 apparmor_file_open
To: Mateusz Guzik <mjguzik@gmail.com>,
 Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Cc: paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
 linux-kernel@vger.kernel.org, apparmor@lists.ubuntu.com,
 linux-security-module@vger.kernel.org
References: <20240620171528.167997-1-mjguzik@gmail.com>
 <155a24f7-8059-49b0-93fa-94bcdc058621@amd.com>
 <CAGudoHFsqDS-5ELmy=t2fdQ2Xrk8q+xyfCkZPpb4XA-+6HOpNA@mail.gmail.com>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <CAGudoHFsqDS-5ELmy=t2fdQ2Xrk8q+xyfCkZPpb4XA-+6HOpNA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/20/24 11:30, Mateusz Guzik wrote:
> On Thu, Jun 20, 2024 at 8:23 PM Neeraj Upadhyay <Neeraj.Upadhyay@amd.com> wrote:
>>
>>
>>
>> On 6/20/2024 10:45 PM, Mateusz Guzik wrote:
>>> apparmor: try to avoid refing the label in apparmor_file_open
>>>
>>> If the label is not stale (which is the common case), the fact that the
>>> passed file object holds a reference can be leverged to avoid the
>>
>> Minor: Typo 'leveraged'
>>
>>> ref/unref cycle. Doing so reduces performance impact of apparmor on
>>> parallel open() invocations.
>>>
>>> When benchmarking on a 24-core vm using will-it-scale's open1_process
>>> ("Separate file open"), the results are (ops/s):
>>> before: 6092196
>>> after:  8309726 (+36%)
>>>
>>> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
>>> ---
>>
>>
>> Trying to understand the changes done here. So, while the file cred can be updated
>> async to the task (referring to the comment from John here [1]), the file cred label
>> cannot change during apparmor_file_open() execution?
>>
> 
> Refing a label retains racy vs refing it.
> 
> On stock code you can test the flag, determine it's not stale, grab
> the ref and have it become stale immediately after. My patch avoids
> the atomic dance for the common case, does not alter anything
> correctness-wise AFAICS.
> 
> I am assuming the race is tolerated and checking here is only done to
> make sure the new label is seen eventually.
> 
> Not having the race is possible with a bunch of trickery like seqc,
> but so far does not look like this is necessary.
> 

the race is some what tolerated because of the nature of what is being
done with the label. Basically labels go stale with policy updates, and
we do not guarantee atomic policy updates as the locking to do so would
cause a lot of performance issues.

Generally for mediation, the label is used in a read only fashion and
the state is taken at the start of hook entry and used the read side
value for the duration of the hook.

If the hook is to update the label it must take a lock and then get
any updated state before continuing to update the label.

This case in particular is unique in that apparmor doesn't update
the f_cred. The label can go stale but the file will continue to
reference the original label frpm the time the f_cred was set. So there
is no race that the f_creds reference might be put. This does however
mean that policy updates might result in the slow path, having to do
a refcount, getting triggered.

The afore mentioned replacement of unconfined and object delegation
work will change what apparmor is doing here and break this but like
I said that is a problem for those patches in the future.


>>
>> Reviewed-by: Neeraj upadhyay <Neeraj.Upadhyay@amd.com>
>>
>>
>> Thanks
>> Neeraj
>>
>> [1] https://lore.kernel.org/lkml/9bfaeec2-535d-4401-8244-7560f660a065@canonical.com/
>>
>>
>>>
>>> v2:
>>> - reword the commit message
>>>
>>> If you want any changes made to it can you just do them on your own
>>> accord? :) Will be faster for both of us than another mail trip.
>>>
>>>   security/apparmor/include/cred.h | 20 ++++++++++++++++++++
>>>   security/apparmor/lsm.c          |  5 +++--
>>>   2 files changed, 23 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/security/apparmor/include/cred.h b/security/apparmor/include/cred.h
>>> index 58fdc72af664..7265d2f81dd5 100644
>>> --- a/security/apparmor/include/cred.h
>>> +++ b/security/apparmor/include/cred.h
>>> @@ -63,6 +63,26 @@ static inline struct aa_label *aa_get_newest_cred_label(const struct cred *cred)
>>>        return aa_get_newest_label(aa_cred_raw_label(cred));
>>>   }
>>>
>>> +static inline struct aa_label *aa_get_newest_cred_label_condref(const struct cred *cred,
>>> +                                                             bool *needput)
>>> +{
>>> +     struct aa_label *l = aa_cred_raw_label(cred);
>>> +
>>> +     if (unlikely(label_is_stale(l))) {
>>> +             *needput = true;
>>> +             return aa_get_newest_label(l);
>>> +     }
>>> +
>>> +     *needput = false;
>>> +     return l;
>>> +}
>>> +
>>> +static inline void aa_put_label_condref(struct aa_label *l, bool needput)
>>> +{
>>> +     if (unlikely(needput))
>>> +             aa_put_label(l);
>>> +}
>>> +
>>>   /**
>>>    * aa_current_raw_label - find the current tasks confining label
>>>    *
>>> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
>>> index 2cea34657a47..4bf87eac4a56 100644
>>> --- a/security/apparmor/lsm.c
>>> +++ b/security/apparmor/lsm.c
>>> @@ -461,6 +461,7 @@ static int apparmor_file_open(struct file *file)
>>>        struct aa_file_ctx *fctx = file_ctx(file);
>>>        struct aa_label *label;
>>>        int error = 0;
>>> +     bool needput;
>>>
>>>        if (!path_mediated_fs(file->f_path.dentry))
>>>                return 0;
>>> @@ -477,7 +478,7 @@ static int apparmor_file_open(struct file *file)
>>>                return 0;
>>>        }
>>>
>>> -     label = aa_get_newest_cred_label(file->f_cred);
>>> +     label = aa_get_newest_cred_label_condref(file->f_cred, &needput);
>>>        if (!unconfined(label)) {
>>>                struct mnt_idmap *idmap = file_mnt_idmap(file);
>>>                struct inode *inode = file_inode(file);
>>> @@ -494,7 +495,7 @@ static int apparmor_file_open(struct file *file)
>>>                /* todo cache full allowed permissions set and state */
>>>                fctx->allow = aa_map_file_to_perms(file);
>>>        }
>>> -     aa_put_label(label);
>>> +     aa_put_label_condref(label, needput);
>>>
>>>        return error;
>>>   }
> 
> 
> 

