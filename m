Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F3324C076
	for <linux-security-module@vger.kernel.org>; Sat,  6 Dec 2025 15:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765035240; cv=none; b=cTd9HZvsyPU4A55MYiUKmHvTRiLjjXCXK2JT/2+RBAq1H7uwKPDw5BlKS9qQuIa2MYb3SCB2TI4tz2LlZRfDGU8uS+Bh9/qB0ukYK7S4Si61goc+FRfia58QauIEQhLsbEMzgy3ATl1LBTjA0b/zxu7s49lpE5MCd5SHsP6APJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765035240; c=relaxed/simple;
	bh=uurNN2w/igODJeeIDmP4EOj//T+tBErcDITI0pAz7H4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MScsgaj0vVGaQBfCVB7bjvRQ6qt8oSOeGtgihQeQRVkisOhcJYIruM+M14lcOY46+xzbXjz5wTI/Zn+GzOkee6fvEGbvmLlrXYmZsEeSCJdEXNGCSCZ41R3kT7/C/Iqdn+bRjFXmPz20vF9BYhVNoauDTQDU/MvyUDIAqZdbGUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QoN02M5E; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QoN02M5E"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-640d790d444so2657611d50.0
        for <linux-security-module@vger.kernel.org>; Sat, 06 Dec 2025 07:33:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765035237; x=1765640037; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fFLLqabnWLbzUrryAmjgzApTqjf4UkDD4VO0vnKvZ6E=;
        b=QoN02M5EmYj382A/w2rCFF9y59dR3fNty+sIUShFqydO0c/Z+YjJ5Mz9bji/PDYsZh
         naaJ7Hdzs/wCdb29rSz8v0u9gFF3dYMavWXlI1lpLF7v51dPBOBLlqhE0ivqAY2t6txc
         Vpsrtq3kVHE1iDGje6z4EEZRnXAVDtmsjXbQ1CO5QOJvTyOfrtRnl6gBcffaPgBUqr1H
         Nn+IJ9JiVJ0vQS3xQZ2OolR8QC3mbEyuk4deGaKHFolwgX7b4u9RbPAvZMOgAef5eCbP
         +Irb18ePXCpOFCW1EfCePyHu8KN4NFXDw/JkNXwdc9v11qAJmS/Ur6yK1GU+f9arFbge
         VDfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765035237; x=1765640037;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fFLLqabnWLbzUrryAmjgzApTqjf4UkDD4VO0vnKvZ6E=;
        b=h+t9clXqA6t/Pv3N7MYo4tv/ITG8qQUx8OKFZf9Vd/OpKHImBZsXDIAX7d0kn9eQMb
         kJa65aPSSjxpZ7wA7NEgL+bkd+MJUeSE8GPQmOZ1rGDdehB3dTw38GR3RlrzagSHy4LO
         iIxAblA+ntu6vvgJJvIgVJBFThZP8TgbJf428aFMjKvw80uRunzLCRROFCePDoBCXNaR
         ufVjI4AqkiT/6WFZKDkiphkTitFEMRuS5OLVHNnyBhDAXumLRCdoDV0niSqXeS9xbOwC
         djZlnot7CL4HL1qvwFceziI8UGxtiRQVgRD9g+ehF8KoRdVT/sHNU7W4vtxLrg2IYeEp
         /2Sw==
X-Forwarded-Encrypted: i=1; AJvYcCVf6ZeDMHsgb5JtS1dgUpTfhaNOCecTm906tw48KgNLh7bQ39PWtX12kX4cRPXkWZ/QrmxORc8mavQD77tvc/YdroelbBc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeWRceqm85FkRSPQ3F1U7JL+M+1UEmW8Bt7F5jg4pYh9zb8EM4
	4Ep3Ta37kkix0OHt72UajOHjP7BwraG02J6lTUEy0SkkizpKtfTg39ib
X-Gm-Gg: ASbGnctwCiTwAH74duCvUCQNFRS76t8FBJ/Yum/NA+43yVa2w/1vw6d6pi0SLk0GRXu
	eMNqF2D9EFTnJZtKeKZZrz7XFPvW9J9sB13PPaXNxQiejsXPSoiz/GTc9H0wKqFnFuuY18PldM+
	6Jc55RK0BFeIpP/OrXy8E8v9EeA98gmudI6vlH8xLEh1Wux6InhEAkasa4BuftebnMSJ9Xivba6
	NftRB5C6/Ql13bi20dAnDHh3IFdwcE2j/HHI6dMEBWK539SSHRHgYHdZbiQE7OUOkTPtdwcjsxg
	5QVRJjIMgtByHJnCgR9gXyvwUYB877saWLINYQYGcK4CQrOj9fWV0loVQ1qoxxrioeCobspD/aB
	MCmn6X0xjW+7SEMA1vH4CMLYJ9PztqWxnsuMBe5bKuoLknC+oU/MWoAyYeEjgtyPinpHCIq2Vv4
	LXuVJFjR8r6SmvP/WG4PiWzWcxFnI2aMkbBL9FvrQca1cKloa25XRqDDusn9E/nrl6zp0G+ro=
X-Google-Smtp-Source: AGHT+IGh7rXfsIyob2PODFRSQZ/kmjvvMh4EG1/4ZiAJPmR9SR7BX82ZY7cps1XEKR+I7XdXt855+w==
X-Received: by 2002:a05:690e:4010:b0:63e:33a7:cdd7 with SMTP id 956f58d0204a3-6444e754607mr2121105d50.20.1765035236886;
        Sat, 06 Dec 2025 07:33:56 -0800 (PST)
Received: from zenbox (71-132-185-69.lightspeed.tukrga.sbcglobal.net. [71.132.185.69])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6443f2abcf8sm3108322d50.4.2025.12.06.07.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Dec 2025 07:33:56 -0800 (PST)
From: Justin Suess <utilityemal77@gmail.com>
To: m@maowtm.org
Cc: gnoack@google.com,
	jack@suse.cz,
	linux-security-module@vger.kernel.org,
	mic@digikod.net,
	utilityemal77@gmail.com,
	xandfury@gmail.com
Subject: Re: [PATCH v3 3/5] samples/landlock: Add LANDLOCK_ADD_RULE_NO_INHERIT to landlock-sandboxer
Date: Sat,  6 Dec 2025 10:33:45 -0500
Message-ID: <20251206153345.442740-1-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <664b4f51-afaa-4dbf-a83f-95a2167eeedb@maowtm.org>
References: <664b4f51-afaa-4dbf-a83f-95a2167eeedb@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It totally does. I think that would be more way more clear and reduce LOC.

It'll be in the next version.

>
>>  	"* " ENV_TCP_BIND_NAME ": ports allowed to bind (server)\n"
>>  	"* " ENV_TCP_CONNECT_NAME ": ports allowed to connect (client)\n"
>>  	"* " ENV_SCOPED_NAME ": actions denied on the outside of the landlock domain\n"
>> @@ -596,17 +604,28 @@ int main(const int argc, char *const argv[], char *const *const envp)
>>  	}
>>  
>>  	if (populate_ruleset_fs(ENV_FS_RO_NAME, ruleset_fd, access_fs_ro,
>> -				false)) {
>> +			0, true)) {
>>  		goto err_close_ruleset;
>>  	}
>>  	if (populate_ruleset_fs(ENV_FS_RW_NAME, ruleset_fd, access_fs_rw,
>> +			0, true)) {
>> +		goto err_close_ruleset;
>> +	}
>> +	/* Optional no-inherit rules mirror the regular read-only/read-write sets. */
>> +	if (populate_ruleset_fs(ENV_FS_RO_NO_INHERIT_NAME, ruleset_fd,
>> +				access_fs_ro, LANDLOCK_ADD_RULE_NO_INHERIT,
>> +				false)) {
>> +		goto err_close_ruleset;
>> +	}
>> +	if (populate_ruleset_fs(ENV_FS_RW_NO_INHERIT_NAME, ruleset_fd,
>> +				access_fs_rw, LANDLOCK_ADD_RULE_NO_INHERIT,
>
> These need to be under an ABI version check like the quiet one - this
> sandboxer is designed to "downgrade" what it tries to do gracefully if
> running on older kernel.
>
> However, there is an argument that maybe if deny rules aren't supported in
> the current running kernel, it should just refuse to run the program at
> all, otherwise by running the sandboxed program without the deny rules it
> might expose the user to risks they might mitigate via some other means.
> But in that case we should still have a better error message when running
> on an older kernel than "Failed to update the ruleset with ...: Invalid
> argument"

Gotcha. I'll put it under the ABI check. 

I think it'd be better to let the user decide if they wanna continue
with the policy if it's using an unsupported feature.

Kind Regards,

Justin Suess

