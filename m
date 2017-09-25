From: john.johansen@canonical.com (John Johansen)
Date: Mon, 25 Sep 2017 12:27:08 -0400
Subject: [PATCH] apparmor: Fix harmless off by one in map_signal_num()
In-Reply-To: <20170925150910.5bo2j2wwwojoyl43@mwanda>
References: <20170901085225.dpuirzpj7aq3yyim@mwanda>
	<d2c82d40-2b1b-163d-85d3-4a902f62e818@canonical.com>
	<20170925150910.5bo2j2wwwojoyl43@mwanda>
Message-ID: <d117fc46-ff6e-584d-2f9a-8fc253e42f7d@canonical.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 09/25/2017 11:09 AM, Dan Carpenter wrote:
> On Mon, Sep 25, 2017 at 10:25:01AM -0400, John Johansen wrote:
>> On 09/01/2017 04:52 AM, Dan Carpenter wrote:
>>> This patch has no effect on runtime.
>>>
>>> The sig_map[] array has MAXMAPPED_SIG (35) members so my static checker
>>> complains that the <= should be <.  But in this case it's not possible
>>> for "sig" to be more than 31 because of the "else if (sig >= SIGRTMIN)"
>>> condition since SIGRTMIN is 32.  The last three elements, 32-34, of
>>> sig_map[] are empty so this code works as designed.
>>>
>>> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>>>
>>> diff --git a/security/apparmor/ipc.c b/security/apparmor/ipc.c
>>> index 66fb9ede9447..5091c78062e4 100644
>>> --- a/security/apparmor/ipc.c
>>> +++ b/security/apparmor/ipc.c
>>> @@ -128,7 +128,7 @@ static inline int map_signal_num(int sig)
>>>  		return SIGUNKNOWN;
>>>  	else if (sig >= SIGRTMIN)
>>>  		return sig - SIGRTMIN + 128;	/* rt sigs mapped to 128 */
>>> -	else if (sig <= MAXMAPPED_SIG)
>>> +	else if (sig < MAXMAPPED_SIG)
>>>  		return sig_map[sig];
>>>  	return SIGUNKNOWN;
>>>  }
>>>
>>
>> Colin King beat you to this one, its in apparmor-next
> 
> apparmor doesn't seem to be in linux-next at all.  Why is that?
> 
hrmmm, apparmor is pulled in via security-next merges, but you are right
apparmor-next isn't being merged and we should set that up.

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
