Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E4B279DB7
	for <linux-security-module@vger.kernel.org>; Mon,  1 Dec 2025 21:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764625186; cv=none; b=VRPXZjeVrU4t75JmPrg0I9gqlkwZDL0FI8dgg0MCCQliOClJzkTfXD6PumxA9TDOrg7NHCcsGoeLwVr1z2mXi2OcvEDtjY3gWR9eCelbM+WTk+q4BMfcmhOnnQ8dWJavCx8UpVdDHQUqP3k6zTV8USPKl6aKnvba32L/J9QmAZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764625186; c=relaxed/simple;
	bh=/RkCgTE/4Sl75hR0rlbGxd11uecUwoBDhtpuhsWfVcA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cgSzw7NSyhB5yyb61hnNnen727fhulTUdIsLuoeEl4cePtdTRHblbVLxZca47fujyvK+YfSuu7T5okj418mQ2ytJv93kKISqUEJZu11mpwXDBkDmWE1EhKHLDtePEg7nRi+jidYXDtmXdnvMZQqIpkhVwmnfOHQRmHv0MTK43ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xgs+HtWy; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xgs+HtWy"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-42e2d5e119fso1119379f8f.2
        for <linux-security-module@vger.kernel.org>; Mon, 01 Dec 2025 13:39:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764625183; x=1765229983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uZmRqhdDnonRvflYIO2SfgDWhvVya0E7TMh9w4AtTjQ=;
        b=Xgs+HtWyK5MQ/jnUBr+KIXECHApj+OALgOKz5VtDzjPSEoR5FInlvgHiZtFUB3z1kK
         U4lUkEBt5mnvZLshW54S4+8YTzEZtZ6xV6iL6RlCQhyCKa9PUBMlbcaf5cBv3v6RMJ1s
         BFQZM+CZZH4u+O8+faUtrMkIZZLphrZfzjqqFvlOyCq7oRa3HEfnaZ/douzRMaStvpzp
         CVNlJUKb235ZbLDqxyhtbaloqGaEjUXjATUGSNNLSg9X7KtXzm8EgJszk0ucghsmrLGc
         ZqDG7pOo5kKkOtEeCb+B1CNyQKzGISircodxMAwfMv+8qB6Xhg+88+xdEq/Tr9C5cCeU
         ZUDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764625183; x=1765229983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uZmRqhdDnonRvflYIO2SfgDWhvVya0E7TMh9w4AtTjQ=;
        b=iDJEXEMZF8K4i/vIDuecMhynrC+YaZozjQ5I/wCs4Kz6h+RcPBgJBH7aUXorDT1IZn
         iMHSsR05HjaAchPwc15JTZl1sI6TisV+8AF46PoKfkIb8y/dzJvp7kufY18OVuEZ+r/Z
         4IqXY6s5uFRZZnKs0QZQdQCC4Gg4b5hfkxSgokGqLaZ3QpEYSyxopSZwYjDW+Sv+pX/S
         Sm3p6qhtH/GxIKchOp1uz45OpA+KqLUf5U3nZ/17Z5aoQqhEIIyDeqs5pz18kSnEoRwa
         D4cgNfaEAHGEoyMzz8GDU2jyFd58FTqQAM3gHsEKGdAz6GuXCECOke/XVmnC6XxTKhWZ
         oT/Q==
X-Forwarded-Encrypted: i=1; AJvYcCV035hl+D2zVhvFLPkCxakOrTUFA9zottbHXn2jJbYyctPTo75ncpzxeiUIOaBezM92viAJc2UH/990MK9Av2Ljcl4VkNw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCozxJ5a1YzYKNdOR2GBvNLzzF/GrXsnP8dnzAHZdvDBhFIfCB
	7GINlAEI7mpHX+fEHyCTJz81z+28ti40iWSZuWIEB0Z9mM1AdATVDGCv
X-Gm-Gg: ASbGnctKMjlJ72065VJnXuQJSx8IZYWeE9t2+IakpzyJe7iskkv8NEw9tTVxDkxp9/9
	R0aBCIaadT3ZQm0S30RAWNd4HM73j66v2aDf1zo13t0buEozdnSsRbNhzD79RzNOPoLB5j7rV8C
	0el+sHxW2nOt+b555cy1UqIcGZthOBz6+pnmLDoaDpjqrKISoCmvAsqP505VODI9Z7f+inI0HZ2
	e0IQTfGkkvy4JK2EXcHTH8MiGJthr27iiBTZRQudTMcOI5FEU6JFqqZuK95n+lD6Blld/eV3YY7
	H0fTH201ZTTBCVVJubC9q59xy4IYw9bpGIITNgpt5XcHk3i7cUuDuGp/Wk8GyJ4tDwRzECaph0m
	jfGNRb/BbuRHh5VPWR2PQSojzqbXzAbvgsV7TW6UdA0JVfuAIDGulZglymszqxYNYqBYmscDwV/
	B48vtSliHSc/KNLCbXmA2Qq3foO2fJZhi7PRFcmUlAbZIxSri4abo+
X-Google-Smtp-Source: AGHT+IF0GP+pqaKG4PhgW/HWMVcgie4ld9+aoLno5OGZiyBWMEqef3f9IS+F+vZ3lhE/VUXuRC3tJA==
X-Received: by 2002:a05:6000:2c0b:b0:429:d0b8:3850 with SMTP id ffacd0b85a97d-42cc1d0cd26mr39852844f8f.48.1764625182679;
        Mon, 01 Dec 2025 13:39:42 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42e1caae37esm28492546f8f.40.2025.12.01.13.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 13:39:42 -0800 (PST)
Date: Mon, 1 Dec 2025 21:39:38 +0000
From: David Laight <david.laight.linux@gmail.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Roberto Sassu <roberto.sassu@huaweicloud.com>, Bernd Edlinger
 <bernd.edlinger@hotmail.de>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Alexey Dobriyan <adobriyan@gmail.com>, Oleg Nesterov <oleg@redhat.com>,
 Kees Cook <kees@kernel.org>, Andy Lutomirski <luto@amacapital.net>, Will
 Drewry <wad@chromium.org>, Christian Brauner <brauner@kernel.org>, Andrew
 Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@suse.com>, Serge
 Hallyn <serge@hallyn.com>, James Morris <jamorris@linux.microsoft.com>,
 Randy Dunlap <rdunlap@infradead.org>, Suren Baghdasaryan
 <surenb@google.com>, Yafang Shao <laoar.shao@gmail.com>, Helge Deller
 <deller@gmx.de>, Adrian Reber <areber@redhat.com>, Thomas Gleixner
 <tglx@linutronix.de>, Jens Axboe <axboe@kernel.dk>, Alexei Starovoitov
 <ast@kernel.org>, "linux-fsdevel@vger.kernel.org"
 <linux-fsdevel@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, linux-kselftest@vger.kernel.org,
 linux-mm@kvack.org, linux-security-module@vger.kernel.org, tiozhang
 <tiozhang@didiglobal.com>, Luis Chamberlain <mcgrof@kernel.org>, "Paulo
 Alcantara (SUSE)" <pc@manguebit.com>, Sergey Senozhatsky
 <senozhatsky@chromium.org>, Frederic Weisbecker <frederic@kernel.org>,
 YueHaibing <yuehaibing@huawei.com>, Paul Moore <paul@paul-moore.com>,
 Aleksa Sarai <cyphar@cyphar.com>, Stefan Roesch <shr@devkernel.io>, Chao Yu
 <chao@kernel.org>, xu xin <xu.xin16@zte.com.cn>, Jeff Layton
 <jlayton@kernel.org>, Jan Kara <jack@suse.cz>, David Hildenbrand
 <david@redhat.com>, Dave Chinner <dchinner@redhat.com>, Shuah Khan
 <shuah@kernel.org>, Elena Reshetova <elena.reshetova@intel.com>, David
 Windsor <dwindsor@gmail.com>, Mateusz Guzik <mjguzik@gmail.com>, Ard
 Biesheuvel <ardb@kernel.org>, "Joel Fernandes (Google)"
 <joel@joelfernandes.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Hans Liljestrand <ishkamiel@gmail.com>, Penglei Jiang
 <superman.xpt@gmail.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Adrian Ratiu <adrian.ratiu@collabora.com>, Ingo Molnar <mingo@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, Cyrill Gorcunov
 <gorcunov@gmail.com>, Eric Dumazet <edumazet@google.com>,
 zohar@linux.ibm.com, linux-integrity@vger.kernel.org, Ryan Lee
 <ryan.lee@canonical.com>, apparmor <apparmor@lists.ubuntu.com>
Subject: Re: Are setuid shell scripts safe? (Implied by
 security_bprm_creds_for_exec)
Message-ID: <20251201213938.184d71db@pumpkin>
In-Reply-To: <87ms42rq3t.fsf@email.froward.int.ebiederm.org>
References: <AM8PR10MB470801D01A0CF24BC32C25E7E40E9@AM8PR10MB4708.EURPRD10.PROD.OUTLOOK.COM>
	<AS8P193MB12851AC1F862B97FCE9B3F4FE4AAA@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
	<AS8P193MB1285FF445694F149B70B21D0E46C2@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
	<AS8P193MB1285937F9831CECAF2A9EEE2E4752@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
	<GV2PPF74270EBEEEDE0B9742310DE91E9A7E431A@GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM>
	<GV2PPF74270EBEE9EF78827D73D3D7212F7E432A@GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM>
	<GV2PPF74270EBEEE807D016A79FE7A2F463E4D6A@GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM>
	<87tsyozqdu.fsf@email.froward.int.ebiederm.org>
	<87wm3ky5n9.fsf@email.froward.int.ebiederm.org>
	<87h5uoxw06.fsf_-_@email.froward.int.ebiederm.org>
	<6dc556a0a93c18fffec71322bf97441c74b3134e.camel@huaweicloud.com>
	<87v7iqtcev.fsf_-_@email.froward.int.ebiederm.org>
	<dca0f01500f9d6705dccf3b3ef616468b1f53f57.camel@huaweicloud.com>
	<87ms42rq3t.fsf@email.froward.int.ebiederm.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 01 Dec 2025 12:53:10 -0600
"Eric W. Biederman" <ebiederm@xmission.com> wrote:

> Roberto Sassu <roberto.sassu@huaweicloud.com> writes:
...
> There is the partial solution of passing /dev/fd instead of passing the
> name of the script.  I suspect that would break things.  I don't
> remember why that was never adopted.

I thought that was what was done - and stopped the problem of a user
flipping a symlink between a suid script and one the user had written.

It has only ever been done for suid scripts when the uid actually changes.
Which makes it possible to set the permissions so that owner can't
run the script!
(The kernel only needs 'x' access, the shell needs 'r' access, so with 'x+s'
the owner can't execute the script but everyone else can.)

There is a much older problem that probably only affected the original 1970s
'sh' (not even the SVSV/Sunos version) that quoted redirects on the command
line would get actioned when the parameter was substituted - which I think
means the original 'sh' did post-substitution syntax analysis (the same
as cmd.exe still does).
That doesn't affect any shells used since the early 1980s.

	David
