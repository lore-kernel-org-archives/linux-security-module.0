Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2C92673B0
	for <linux-security-module@vger.kernel.org>; Fri, 12 Jun 2026 01:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781226783; cv=none; b=clSDqinGGS8p5nkbq6u8dxlSiPHUuWiWV0CDK0m5sNz48EGuUiDoapTxkosEbZIGQDZ5f2EtYaV7FXMIJgx5foz3G/yNTGLsSaddvNYo9Od5hBPHiBlDj65eUMEEKUkgwFgK8dWhw7fDckHlbOpaVcXTb/zvZLI03nYmy4CiaRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781226783; c=relaxed/simple;
	bh=7QBFaCwxv8jZF//sEqrhlmLHQRZABOXyLyA9OuD6sdc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gLzGHQ7ilOOc1uht8dK2yrVcCkDtAVo9KgANVIHqMgzwIZG80MiJXl+iQvsLwiB6cyqZK1vuio/IBv8oWlz1ETUulvayi/GbLVvqCocBZCchGmPPwHJHME22rraKOWtuKYoCn9xvkNcmm6UQbZiCFTMF9wRrGGWwkX+YCzx/YYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=MSX6UHwE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=G/muH/E4; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="MSX6UHwE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="G/muH/E4"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3E02A7A0113;
	Thu, 11 Jun 2026 21:13:01 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Thu, 11 Jun 2026 21:13:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781226781;
	 x=1781313181; bh=BMCW527DrbEHXva26l3fHghWyaVQSU6KYOjGKnGqFrU=; b=
	MSX6UHwESpj0pfmoJZbtj6IB8luNkMbv9UpM1yV8z8gbmqC+IOJqjhsiYUUcW0Iu
	FYrgYHvLUuexiFYMONpedXZWwYLir2+1+jrOvMFUwyF0yYpDqR0ek7wWS1PdyXdj
	uPsYM6YEwzgaoygKtINyMy9LwCPOHmPol96qdxtpVYcJrMdWkVHSAzQG2A5vfE5C
	mKgUo0YCKSCl/UAJ2WSuTqJXk+zKYKp96EyOQuG3ut3+xPUhRIpJNtLcasJh0VfA
	N19K54m6Pi+g2W+8g5mwfn6CM08mRQ88MtYM7oeax6bOwTZbeRPhjMNM2YXGtNvi
	FFMU8pmh8Jfk49Y33QLEhQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781226781; x=
	1781313181; bh=BMCW527DrbEHXva26l3fHghWyaVQSU6KYOjGKnGqFrU=; b=G
	/muH/E4niMimMO88l7sfMd32X4bOQ5ANas6DZOj6rhNbXZABclpWgPVyM1sRBMaN
	ub1/KxmMbU7dqwZ8PrqkTnPN6tPE8caEDBIFNGo/jr7kgcogYYW++ezoYfUCY0n6
	yq8biOefsWb0boEOk9tG80jzfWQibaHUb2U2kQV01JlHNzemTaHR/Byuhkct12Vl
	1A//IH/Iv0qmqF+/AsUwO6dfk9RUeg3bgB7UV9lPkZZ1FjOHXDM/ZSdOYNt3B+v8
	CTRc70H1Z40l+Q2kXPo+/iMt+aF6oq4aaxhMo16io307N7k0xM34YZ+eZ61tpZD1
	Kytq6FTBeOXsw5ha9b17g==
X-ME-Sender: <xms:HF0ratjmBUJdt1vyrA2NqsqfhNXZMGCt2L4q5mOXJSSv1TvBJBIN9g>
    <xme:HF0ralubeoCxNr5l3-hFqV9BK26bcgB68Z4lwcJ2r6nZJb9L9XnCbTtJL32QGdrEn
    t4e_dIcYkbLi0Yj0a-1J_1K0PUKC4pG5r2tGhHXiHiSR9enPJCAm3ep>
X-ME-Received: <xmr:HF0ram5Cb0ZUhy42S-acVZrji6gmQydrksviAlY2c4dWYWr8AXTj5-zUM5jVHqdQkeJWMCWbzYIQuZBHWQ>
X-ME-Proxy-Cause: dmFkZTF/ZzgcodfEGQOF/MA31cvgKlhVRzO9QKpJ9lmdpMV6t0KvYkRCHp+UVlhNEGz1oC
    WavJaJ5lCNnpogyn0GW5jV4y+9SYDKjWvslEHaH5HDMwgclbf5gW4mue7/lCbwBdnsAxq9
    79jK3E+FaB7FwZoiygqbEebKcPKGRRBB184g43KpdOtgi37o47cTVGoTjtZBNRjwaKdXei
    Bhik+pcQUXUTvsNXnUNt2dHV9jGfzjM3vZ5i1ijjMzmUyhQuikko8AYwPMmdckfNCpFbS8
    idfDsMMhXtS+K0ii3o/PXKZsNleHUgPYuZQAdB2SXIg71oHY47wcQ1N8J/+0fxFjVj0Qm2
    f0cO9HF8hCc6sVfRIQ+kTvDZBhLoA3KAYwizLGW7iLEuUFK0m17HGbhfmT5KoKxHfKb/SU
    ERInFsYF/nLyuju8guhz4B8xw/sQbBO4Bst40i0bhxacy42Dj23FGfBf9crpo7YL5iG7PC
    KJdfkpOhFGzm5cRYcywjlcAJzpRgLPqPXp8Ifg+oGdrvxMby8MSoss2xwMiuVZfF98q+pi
    heH04yKx+kF7xuHY0A99XGFLhR1ilL6B2pa/hVLyX8QqwbCaMF0AfXN2YvKPB/bzc1pLN8
    xjiX3gkSaLqg2JzM1qA+Zwov19z1Tc4X+B5UFDWTOAdlSWrqzgxHH7EZS2Xg
X-ME-Proxy: <xmx:HF0rapOMY3hUIDRZsj_X1K0JlOePYNk63dCeOot4Ib4cQ2S1zSEiRw>
    <xmx:HF0rasu7qCpW5roVT44X0z0f21r_4ZSUZ76omlJlGpfTcLxWyD5stQ>
    <xmx:HF0rakZ25HqXqc4mo98Vuc1lO6uqaXwiGwaKNbjhbqv-2QrqCd7NfQ>
    <xmx:HF0ramy2GWB9hI5ZdsewJkrVgPIEnwA5Afiw1iwVOIgtzHsLZd5hcA>
    <xmx:HV0rautJgAtjUJL6PmBaZnh2Evqo7lV_JihGfM_r8rC0Pi6kssjPIJQJ>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Jun 2026 21:12:59 -0400 (EDT)
Message-ID: <7f55af95-e18f-4911-8cad-6edf4f5d2bb9@maowtm.org>
Date: Fri, 12 Jun 2026 02:12:58 +0100
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 4/9] samples/landlock: Add quiet flag support to
 sandboxer
To: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>,
 Justin Suess <utilityemal77@gmail.com>, Jan Kara <jack@suse.cz>,
 Abhinav Saxena <xandfury@gmail.com>, linux-security-module@vger.kernel.org
References: <cover.1780272022.git.m@maowtm.org>
 <9a90a123beb481c5be345e0d169eb14295803678.1780272022.git.m@maowtm.org>
 <20260609.Pi8aiyae5nee@digikod.net>
Content-Language: en-US
From: Tingmao Wang <m@maowtm.org>
In-Reply-To: <20260609.Pi8aiyae5nee@digikod.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/8/26 23:41, Mickaël Salaün wrote:
> As for LL_FORCE_LOG, using a QUIET flag not supported should exit with
> an error.

As in, if the current kernel doesn't support quiet flags? Added check.

> 
> On Mon, Jun 01, 2026 at 01:00:38AM +0100, Tingmao Wang wrote:
>> Adds ability to set which access bits to quiet via LL_*_QUIET_ACCESS (FS,
>> NET or SCOPED), and attach quiet flags to individual objects via
>> LL_*_QUIET for FS and NET.
>>
>> Signed-off-by: Tingmao Wang <m@maowtm.org>
>> ---
>>
>> Changes in v10:
>> - Remove stray __attribute__((fallthrough)); (Thanks Justin for
>>   spotting)
>>
>> Changes in v9:
>> - Add udp connect / bind quiet flag support
>>
>> Changes in v8:
>> - Rebase on top of mic/next
>> - populate_ruleset_net() already does not require the env var to be
>>   present, so remove redundant comment and check above
>>   populate_ruleset_net(ENV_NET_QUIET_NAME, ...).
>>
>> Changes in v6:
>> - Make populate_ruleset_{fs,net} take a flags argument instead of a bool
>>   quiet (suggested by Justin Suess)
>> - Fix if braces style
>>
>> Changes in v3:
>> - Minor change to the above commit message.
>>
>> Changes in v2:
>> - Added new environment variables to control which quiet access bits to
>>   set on the rule, and populate quiet_access_* from it.
>> - Added support for quieting net rules and scoped access.  Renamed patch
>>   title.
>> - Increment ABI version
>>
>>  samples/landlock/sandboxer.c | 133 ++++++++++++++++++++++++++++++++---
>>  1 file changed, 122 insertions(+), 11 deletions(-)
>>
>> diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
>> index 94e399e6b146..73a81ecd3696 100644
>> --- a/samples/landlock/sandboxer.c
>> +++ b/samples/landlock/sandboxer.c
>> @@ -58,9 +58,14 @@ static inline int landlock_restrict_self(const int ruleset_fd,
>>  
>>  #define ENV_FS_RO_NAME "LL_FS_RO"
>>  #define ENV_FS_RW_NAME "LL_FS_RW"
>> +#define ENV_FS_QUIET_NAME "LL_FS_QUIET"
>> +#define ENV_FS_QUIET_ACCESS_NAME "LL_FS_QUIET_ACCESS"
>>  #define ENV_TCP_BIND_NAME "LL_TCP_BIND"
>>  #define ENV_TCP_CONNECT_NAME "LL_TCP_CONNECT"
>> +#define ENV_NET_QUIET_NAME "LL_NET_QUIET"
>> +#define ENV_NET_QUIET_ACCESS_NAME "LL_NET_QUIET_ACCESS"
>>  #define ENV_SCOPED_NAME "LL_SCOPED"
>> +#define ENV_SCOPED_QUIET_ACCESS_NAME "LL_SCOPED_QUIET_ACCESS"
>>  #define ENV_FORCE_LOG_NAME "LL_FORCE_LOG"
>>  #define ENV_UDP_BIND_NAME "LL_UDP_BIND"
>>  #define ENV_UDP_CONNECT_SEND_NAME "LL_UDP_CONNECT_SEND"
>> @@ -119,7 +124,7 @@ static int parse_path(char *env_path, const char ***const path_list)
>>  /* clang-format on */
>>  
>>  static int populate_ruleset_fs(const char *const env_var, const int ruleset_fd,
>> -			       const __u64 allowed_access)
>> +			       const __u64 allowed_access, __u32 flags)
>>  {
>>  	int num_paths, i, ret = 1;
>>  	char *env_path_name;
>> @@ -169,7 +174,7 @@ static int populate_ruleset_fs(const char *const env_var, const int ruleset_fd,
>>  		if (!S_ISDIR(statbuf.st_mode))
>>  			path_beneath.allowed_access &= ACCESS_FILE;
>>  		if (landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
>> -				      &path_beneath, 0)) {
>> +				      &path_beneath, flags)) {
>>  			fprintf(stderr,
>>  				"Failed to update the ruleset with \"%s\": %s\n",
>>  				path_list[i], strerror(errno));
>> @@ -187,7 +192,7 @@ static int populate_ruleset_fs(const char *const env_var, const int ruleset_fd,
>>  }
>>  
>>  static int populate_ruleset_net(const char *const env_var, const int ruleset_fd,
>> -				const __u64 allowed_access)
>> +				const __u64 allowed_access, __u32 flags)
>>  {
>>  	int ret = 1;
>>  	char *env_port_name, *env_port_name_next, *strport;
>> @@ -215,7 +220,7 @@ static int populate_ruleset_net(const char *const env_var, const int ruleset_fd,
>>  		}
>>  		net_port.port = port;
>>  		if (landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
>> -				      &net_port, 0)) {
>> +				      &net_port, flags)) {
>>  			fprintf(stderr,
>>  				"Failed to update the ruleset with port \"%llu\": %s\n",
>>  				net_port.port, strerror(errno));
>> @@ -303,6 +308,58 @@ static bool check_ruleset_scope(const char *const env_var,
>>  
>>  /* clang-format on */
>>  
>> +static int add_quiet_access(__u64 *const quiet_access,
>> +			    const __u64 handled_access,
>> +			    const char *const env_var, const bool default_all)
>> +{
>> +	char *env_quiet_access, *env_quiet_access_next, *str_access;
>> +
>> +	if (default_all)
>> +		*quiet_access = handled_access;
>> +	else
>> +		*quiet_access = 0;
>> +
>> +	env_quiet_access = getenv(env_var);
>> +	if (!env_quiet_access)
>> +		return 0;
>> +
>> +	env_quiet_access = strdup(env_quiet_access);
>> +	env_quiet_access_next = env_quiet_access;
>> +	unsetenv(env_var);
>> +	*quiet_access = 0;
>> +
>> +	while ((str_access = strsep(&env_quiet_access_next, ENV_DELIMITER))) {
>> +		if (strcmp(str_access, "") == 0)
>> +			continue;
>> +		else if (strcmp(str_access, "r") == 0)
>> +			*quiet_access |= ACCESS_FS_ROUGHLY_READ;
>> +		else if (strcmp(str_access, "w") == 0)
>> +			*quiet_access |= ACCESS_FS_ROUGHLY_WRITE;
>> +		else if (strcmp(str_access, "b") == 0)
>> +			*quiet_access |= LANDLOCK_ACCESS_NET_BIND_TCP;
> 
> What happen if we set "b" in LL_FS_QUIET_ACCESS?
> 
>> +		else if (strcmp(str_access, "c") == 0)
>> +			*quiet_access |= LANDLOCK_ACCESS_NET_CONNECT_TCP;
>> +		else if (strcmp(str_access, "ub") == 0)
> 
> I don't really like these access-right names, they are not consistent.
> All these env variables add a lot of complexity too.  What about just
> being able to quiet a path or a port?  That would mean renaming
> LL_FS_QUIET_ACCESS to LL_FS_QUIET.

I'm happy to remove LL_{FS,NET}_QUIET_ACCESS and just have
LL_{FS,NET}_QUIET quiet all access, but then we lose the ability to demo
"quiet only read but still log write" via the sandboxer.

I do agree the "b in LL_FS_QUIET_ACCESS" case is weird, so maybe we can
just have one LL_QUIET_ACCESS variable?

Also, the names are like this because I tried to mimic the one-letter
scoped access, but we could use e.g.
LL_QUIET_ACCESS=read:write:tcp_bind:tcp_connect:udp_bind:udp_connect:abstract_unix_socket:signal

Do you want to keep the ability to specify LL_QUIET_ACCESS?  (I think it's
useful for demo, since I expect "quiet read but log write denials" to be
quite common.)

> 
> Anyway, all should be unsetenv() unconditionally.

I think they are already all unsetenv()'d already (checked with
/usr/bin/env), do you mean to make them not conditional on the env
existing in the first place?  I followed how populate_ruleset_{fs,net}
works and those two functions currently do conditional unsetenv(),
althouygh check_ruleset_scope() does it unconditionally.

> 
>> +			*quiet_access |= LANDLOCK_ACCESS_NET_BIND_UDP;
>> +		else if (strcmp(str_access, "uc") == 0)
>> +			*quiet_access |= LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP;
>> +		else if (strcmp(str_access, "a") == 0)
>> +			*quiet_access |= LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET;
>> +		else if (strcmp(str_access, "s") == 0)
>> +			*quiet_access |= LANDLOCK_SCOPE_SIGNAL;
>> +		else {
>> +			fprintf(stderr, "Unknown quiet access \"%s\"\n",
>> +				str_access);
>> +			free(env_quiet_access);
>> +			return -1;
>> +		}
>> +	}
>> +
>> +	free(env_quiet_access);
>> +	*quiet_access &= handled_access;
>> +	return 0;
>> +}
>> +
>>  #define LANDLOCK_ABI_LAST 10
>>  
>>  #define XSTR(s) #s
>> [...]
