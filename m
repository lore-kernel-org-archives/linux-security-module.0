Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC3C3A9D8C
	for <linux-security-module@vger.kernel.org>; Wed, 21 Jan 2026 09:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768988268; cv=none; b=f+qerkEc0pxtUlTTlppz69k0Y8t7+vvrL12YyM6XiM4/t8GRFwlGqIxJW26rN1RzkfBk/FwRZ0GZKbOrc3jnr/emrmNZJM5yH26ThoDawrFCFJQHv7ybHpNIeSe0c+c8oJ+8bw2s5zdYlEPxWsDAzvKdqx0+YAZUbyeIIvqx/fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768988268; c=relaxed/simple;
	bh=3Y5ZT2VCoepAX5qzQunqbwa1vfvEuZu4MagMfD+bqDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OmlSzwt9bm+PhMY/8coru2CN9r26roaoLFC+do16lVhM14Mk6Hc4uyyAK/kLizuZ88sZ3tpi4DZGev6od6Zb0wBzQ4IunMYgje37ikpG8QzyrO115WC6HcTXQt3BjKyOfuCq0/LekytgGAP5N9Wog1yqQWFKLaV1Uc3SUTR0eNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3REDpPS+; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3REDpPS+"
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-43591b55727so1164280f8f.3
        for <linux-security-module@vger.kernel.org>; Wed, 21 Jan 2026 01:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768988264; x=1769593064; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iXqeTKnaesD/s95x6BykBBgnpofIAgHmHNlWTvmzDVU=;
        b=3REDpPS+D2Njc3+r5+f1S2k+EXMe96UQbPFS5Z+PboUNVF9v+4UPgBn7M1VkZhVeag
         9Bf661NusvKHvnNBP2ob2NZBsUjkLUZh6PZKLBIu7VqJc348fnYt0ESbjrRxDQqmEVBL
         adKvappSg3VWdTwDfRFEqnk0dUClhWB6E/sNhzsIWKrf8HC0fKn4CU86YZPsvXB2Nq+B
         xVDQ+sI5qYUbemp7fwNPh2t3bxRvTRX+YV4hQgUH7snC8IX1BMLv6g7JuliuGE4VX4EV
         HmCFsw4c+aNz/dG1IGH6sdJUznBXBPyVvYHxNkCtZ5S2IfP22PX7Saccb1kGUHHDGu2/
         32NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768988264; x=1769593064;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iXqeTKnaesD/s95x6BykBBgnpofIAgHmHNlWTvmzDVU=;
        b=rwlvqeEgI7Ow+WpmHfGxBx1t+n7fjChbcTcva2HYT/f5suIAqYsyPHxvsjncy0XBKD
         v03Rs9BkyQQ3UnJfl00TxSjfjOHQ7F14uf70KJ0nF40DpSPLHgUzhxQu0u+UtQ6CUnjV
         q0uAtZ93zXHV9oN3jBMelzw8M75uopUKnYc3b++Ux1bJXZKJOLjbIfexBZUZVBw24zoL
         nWF83Tt/ovbVupt2FGt4i2mnvTTJ/ExFb/Dub5Fz4tC3Xxl0pt6ZGw0reze2jbvsGejt
         Tl/3yRV9HTlQcl41+/vcGD8cgSW52hOC7NoRF16DZPHQwlA0Ei6aaMG4JdbqDCHbsp0x
         k+BA==
X-Forwarded-Encrypted: i=1; AJvYcCVtnDTHbz7tUyFKmlzxgW/AlFGt/DVlxIrob+e52LU2xajDVCbCPzGwA/eCPvUp1TOMdNUYac+E4/AK21fCdl5cpL7oHdM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxVYSDmtZ1OSq7zrmV07ChTyikIOv8OGEqnYn4RKLnK6fsH5lk
	g+tB3aef27k0J5nPhvVFEw/rnRiY9DGv3ATj1FuabFnBeqP8H1kWMwOBVrGbwTvu0p95MXIMVeS
	yStJTQKtMzvg=
X-Gm-Gg: AZuq6aI7hLQafwZDYehc2RL9AO6/K+QQAP8HFZldetyQqo2UXMXZEWnLhOOBoEldTZm
	FABdSzH1hsPKBXmz+zJGNf2Zo7dVo30WliS7jXlxkuafeHK+dpB/xjwqUA/tktMCVMBi5ingyPM
	KtOHjOJ5pz0/rV54tdbw/bPmLx9Zer5Ia7Dbm0HmujOABJejm09+nRZVWkguf4ME9ITrPPFy1fO
	LMjtOrXkwhYdWsUr9LHZhOX0ibIPLztovcado1dUWsYKPLowu6N8vlAotm9OqpTbcY7q9zNfjSd
	cMUkFoOV0umETYmmXPOtUCnajlWAYH+jNt2EwexZ50TxAdrPMfvmuT8ZoXsMO40adP8jfXJELLu
	NjDyb9Re6pKYM297AGEZk80NaHSUgSdQxEk/yM8PYvy2SKoAhXnNjPBWuJXaO+U4wM8jfFYrDc6
	6fLclgcIWJSayS9KH5QvGAtN1Il6JicgRFRNSZOrtveQ==
X-Received: by 2002:a05:6000:2282:b0:431:abb:942f with SMTP id ffacd0b85a97d-4356a083757mr25813356f8f.54.1768988264074;
        Wed, 21 Jan 2026 01:37:44 -0800 (PST)
Received: from google.com ([2a00:79e0:288a:8:4dcd:eab0:72dc:f1a9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43596b62700sm6518170f8f.42.2026.01.21.01.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 01:37:43 -0800 (PST)
Date: Wed, 21 Jan 2026 10:37:38 +0100
From: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
To: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
Cc: mic@digikod.net, linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] landlock: Add missing ABI 7 case in documentation
 example
Message-ID: <aXCeYnLuKMaNmaP0@google.com>
References: <20260103002722.1465371-1-samasth.norway.ananda@oracle.com>
 <20260103002722.1465371-2-samasth.norway.ananda@oracle.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260103002722.1465371-2-samasth.norway.ananda@oracle.com>

Thanks for the updated documentation!

The comments below are mostly about the structure in the bigger
document context.  The wording seems good.

On Fri, Jan 02, 2026 at 04:27:13PM -0800, Samasth Norway Ananda wrote:
> Add the missing case 6 and case 7 handling in the ABI version
> compatibility example to properly handle ABI < 7 kernels.
> 
> Add an optional backwards compatibility section for restrict flags
> between the case analysis and landlock_restrict_self() call. The main
> tutorial example remains unchanged with
> landlock_restrict_self(ruleset_fd, 0) to keep it simple for users who
> don't need logging flags.
> 
> Also fix misleading description of the /usr rule which incorrectly
> stated it "only allow[s] reading" when the code actually allows both
> reading and executing (LANDLOCK_ACCESS_FS_EXECUTE is included in
> allowed_access).
> 
> Signed-off-by: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
> ---
>  Documentation/userspace-api/landlock.rst | 35 +++++++++++++++++++++---
>  1 file changed, 31 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
> index 1d0c2c15c22e..650c7b368561 100644
> --- a/Documentation/userspace-api/landlock.rst
> +++ b/Documentation/userspace-api/landlock.rst
> @@ -127,6 +127,12 @@ version, and only use the available subset of access rights:
>          /* Removes LANDLOCK_SCOPE_* for ABI < 6 */
>          ruleset_attr.scoped &= ~(LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET |
>                                   LANDLOCK_SCOPE_SIGNAL);
> +        __attribute__((fallthrough));
> +    case 6:
> +        /* Removes logging flags for ABI < 7 */
> +        __attribute__((fallthrough));
> +    case 7:
> +        break;
>      }

This code does nothing, and the comment about removing logging flags
is unclear in that context without pointing to the later section.
IMHO we can either say that logging flags are removed in the code
further below, or just leave it out.

The "case 7" case is not necessary.

>  
>  This enables the creation of an inclusive ruleset that will contain our rules.
> @@ -142,8 +148,9 @@ This enables the creation of an inclusive ruleset that will contain our rules.
>      }
>  
>  We can now add a new rule to this ruleset thanks to the returned file
> -descriptor referring to this ruleset.  The rule will only allow reading the
> -file hierarchy ``/usr``.  Without another rule, write actions would then be
> +descriptor referring to this ruleset.  The rule will allow reading and
> +executing files in the ``/usr`` hierarchy.  Without another rule, write actions
> +and other operations (make_dir, remove_file, etc.) would then be
>  denied by the ruleset.  To add ``/usr`` to the ruleset, we open it with the
>  ``O_PATH`` flag and fill the &struct landlock_path_beneath_attr with this file
>  descriptor.
> @@ -191,10 +198,30 @@ number for a specific action: HTTPS connections.
>      err = landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
>                              &net_port, 0);
>  
> +Backwards compatibility for restrict flags
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

If you were to add this header, then the section about prctl() and
landlock_restrict_self() would also now appear under "Backwards
compatibility for restrict flags", and that would be confusing.  I
would recommend to drop the header for now and clarify in the text
what it is about.  (IMHO, it is visually reasonably easy to understand
the structure of the different sections, as they always follow the
structure "text + code snippet".)

If we want to introduce a new level of headers below "Defining and
enforcing a security policy", we would have to introduce subsections
for the other steps as well, so that it is more structured.  (If we
wanted to do that though, it would probably be better to do it in a
separate commit.)


> +When passing a non-zero ``flags`` argument to ``landlock_restrict_self()``, the
> +following backwards compatibility check needs to be taken into account:
> +
> +.. code-block:: c
> +
> +    /*
> +     * Desired restriction flags, see ABI version section above.
                                         ^^^^^^^^^^^^^^^^^^^^^^^^^

The ABI section does not talk about the restriction flags much;
I would have expected that to link to the place where the restriction
flags are documented, which would be the system call documentation
from the header?

https://docs.kernel.org/userspace-api/landlock.html#enforcing-a-ruleset

> +     * This value is only an example and differs by use case.
> +     */
> +    int restrict_flags = LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON;
> +    if (abi < 7) {
> +        /* Clear logging flags unsupported in ABI < 7 */
> +        restrict_flags &= ~(LANDLOCK_RESTRICT_SELF_LOG_SAME_EXEC_OFF |
> +                           LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON |
> +                           LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF);
> +    }
> +
>  The next step is to restrict the current thread from gaining more privileges
>  (e.g. through a SUID binary).  We now have a ruleset with the first rule
> -allowing read access to ``/usr`` while denying all other handled accesses for
> -the filesystem, and a second rule allowing HTTPS connections.
> +allowing read and execute access to ``/usr`` while denying all other handled
> +accesses for the filesystem, and a second rule allowing HTTPS connections.
>  

If you are setting a "restrict_flags" variable here, then you would
also need to use that variable in the call to landlock_restrict_self()
in the documentation below, so that the different code sections in the
documentation work together.

—Günther
