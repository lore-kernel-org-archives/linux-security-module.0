From: penguin-kernel@I-love.SAKURA.ne.jp (Tetsuo Handa)
Date: Thu, 23 Aug 2018 23:28:52 +0900
Subject: [PATCH] apparmor: remove unused label
In-Reply-To: <CAGXu5jJpuPuu+QYhzGc3MbVU7zL0kWfGMOQRf7zg++8WX4TMgw@mail.gmail.com>
References: <20180823140917.3060915-1-arnd@arndb.de>
	<CAGXu5jJpuPuu+QYhzGc3MbVU7zL0kWfGMOQRf7zg++8WX4TMgw@mail.gmail.com>
Message-ID: <af63df0d-4b06-4095-4a7c-de3f4c1b9026@I-love.SAKURA.ne.jp>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 2018/08/23 23:21, Kees Cook wrote:
> On Thu, Aug 23, 2018 at 7:09 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>> After the corresponding 'goto' was removed, we get a warning
>> for the 'fail' label:
>>
>> security/apparmor/policy_unpack.c: In function 'unpack_dfa':
>> security/apparmor/policy_unpack.c:426:1: error: label 'fail' defined but not used [-Werror=unused-label]
>>
>> Fixes: fb5841091f28 ("apparmor: remove no-op permission check in policy_unpack")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> 
> -Kees
> 
>> ---
>>  security/apparmor/policy_unpack.c | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/security/apparmor/policy_unpack.c b/security/apparmor/policy_unpack.c
>> index 3647b5834ace..96d8cf68ce65 100644
>> --- a/security/apparmor/policy_unpack.c
>> +++ b/security/apparmor/policy_unpack.c
>> @@ -423,7 +423,6 @@ static struct aa_dfa *unpack_dfa(struct aa_ext *e)
>>
>>         return dfa;
>>
>> -fail:
>>         aa_put_dfa(dfa);
>>         return ERR_PTR(-EPROTO);

If these lines are unreachable, please remove together...
And that is what Gustavo A. R. Silva reported before this patch?

>>  }
>> --
>> 2.18.0
>>
> 
> 
> 
