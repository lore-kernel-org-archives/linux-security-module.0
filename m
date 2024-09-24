Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 824CE13B280
	for <linux-security-module@vger.kernel.org>; Tue, 24 Sep 2024 16:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727195573; cv=none; b=l/ndz8VTxgXlwTm/FLODsTVVu8blqKBimBP8/XlRE2g6OdX1jCWAOoVKSdVJVkNMQ3H4tCnUJFsaudeUdGhGRWZyU6RQjw1wd37nV7g7dGEXArXaylJvMZxmLZ4JS+GHPS06u8aXjCkFvN6U+7nH0nNpD8/q385iW3KPNII4ZBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727195573; c=relaxed/simple;
	bh=9ysKhLFK/zLfoFSRFnzHuvu0sFhKus+/ps6xpWUfLKA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VjS9diKLfIpQvr7BVRXLNI+q6WGwR6faOOq6mERQbmItCSOqzqGX+5CnyrC5fbfpany+p61mMmZmw5MZTekesfvAZ0AiUEexXLkiRJXubBU2riZGezCHMgo/rJZZhXCpV7Ry9VTqzpeLpPPTdQVlgylylhvtz09x3M7nuyHyAJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=bLTdwPz1; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="bLTdwPz1"
Received: from [10.137.106.151] (unknown [131.107.174.23])
	by linux.microsoft.com (Postfix) with ESMTPSA id 024A720C649C;
	Tue, 24 Sep 2024 09:32:52 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 024A720C649C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1727195572;
	bh=hqA8AUv4uTInIS/TeSrbfpfbX4JOAbhwPv5wyWbDmP8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bLTdwPz1eqRod1AKwbzuAIqvYyPZ92eT9OtraYcwIzAZxlhEaSORCkshrR/n2+GkQ
	 UsPSBZfim/AI8dB4HxBixE+oJkLGMdbCNCaqpyN2/u6fttqbTQ7kAizf33TgAE+50H
	 Qld8D/7aQYkUtsNswPjwIf3UujGQPreo5RJ+zxek=
Message-ID: <255d857b-2578-4d49-9a17-f0aa4bba3b44@linux.microsoft.com>
Date: Tue, 24 Sep 2024 09:32:51 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] ipe: also reject policy updates with the same version
To: Luca Boccassi <luca.boccassi@gmail.com>
Cc: linux-security-module@vger.kernel.org, paul@paul-moore.com
References: <20240922135614.197694-1-luca.boccassi@gmail.com>
 <20240922135614.197694-2-luca.boccassi@gmail.com>
 <4a8414c5-6df1-40aa-b538-a1b4c48f8f1f@linux.microsoft.com>
 <CAMw=ZnR0M+tsLnoNAeb_+NNw4167qtU-O_Pm3NiFjwaGY5AXWQ@mail.gmail.com>
Content-Language: en-US
From: Fan Wu <wufan@linux.microsoft.com>
In-Reply-To: <CAMw=ZnR0M+tsLnoNAeb_+NNw4167qtU-O_Pm3NiFjwaGY5AXWQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 9/23/2024 2:48 PM, Luca Boccassi wrote:
> On Mon, 23 Sept 2024 at 20:01, Fan Wu <wufan@linux.microsoft.com> wrote:
>>
>>
>>
...
>> Hi Luca,
>>
>> Can you elaborate more about the potential confusion for the userspace
>> users?
>>
>> The policy version is currently used to prevent the activation of
>> outdated or vulnerable policies (e.g., to avoid activating a policy
>> trusting a compromised device). The version is not incremented unless a
>> vulnerability is identified. Essentially, version comparison acts as a
>> minimum threshold, ensuring only policies that meet or exceed this
>> version can be activated.
> 
> "Version" suggests something that is bumped every time there is a
> change, that's usually what the term is used for. The fact that one
> can change the policy without changing the version confused me a lot.
> Perhaps it should be renamed to "generation" or so, to make it more
> clear that it is not intended to be changed every time, but just to
> signal the start of a new generation to avoid downgrade attacks?
> 

I’m inclined to keep the 'version' name, but I agree with your point. 
Requiring a newer version for policy updates makes sense to me. As for 
the version check in ipe_set_active_pol(), we can maintain the current 
behavior, allowing the version to continue serving as a minimum 
threshold for activating a policy. In this case, I think the only change 
needed for this patch is to update the documentation for the `update` 
operation.

-Fan

