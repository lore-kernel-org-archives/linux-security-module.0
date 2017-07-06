From: john.johansen@canonical.com (John Johansen)
Date: Thu, 6 Jul 2017 08:50:47 -0700
Subject: [PATCH] apparmor: Fix shadowed local variable in
	unpack_trans_table()
In-Reply-To: <20170706134428.GA19254@mail.hallyn.com>
References: <1499331381-32753-1-git-send-email-geert@linux-m68k.org>
	<20170706134428.GA19254@mail.hallyn.com>
Message-ID: <f56df828-320c-914d-58fb-a332aec33dcb@canonical.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 07/06/2017 06:44 AM, Serge E. Hallyn wrote:
> Quoting Geert Uytterhoeven (geert at linux-m68k.org):
>> with W=2:
>>
>>     security/apparmor/policy_unpack.c: In function ?unpack_trans_table?:
>>     security/apparmor/policy_unpack.c:469: warning: declaration of ?pos? shadows a previous local
>>     security/apparmor/policy_unpack.c:451: warning: shadowed declaration is here
>>
>> Rename the old "pos" to "saved_pos" to fix this.
>>
>> Fixes: 5379a3312024a8be ("apparmor: support v7 transition format compatible with label_parse")
>> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> 
> Reviewed-by: Serge Hallyn <serge@hallyn.com>
Acked-by: John Johansen <john.johansen@canonical.com>

I will pull this into my tree for my next pull request

> 
>> ---
>>  security/apparmor/policy_unpack.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/security/apparmor/policy_unpack.c b/security/apparmor/policy_unpack.c
>> index c600f4dd1783252a..2d5a1a007b062a73 100644
>> --- a/security/apparmor/policy_unpack.c
>> +++ b/security/apparmor/policy_unpack.c
>> @@ -448,7 +448,7 @@ static struct aa_dfa *unpack_dfa(struct aa_ext *e)
>>   */
>>  static bool unpack_trans_table(struct aa_ext *e, struct aa_profile *profile)
>>  {
>> -	void *pos = e->pos;
>> +	void *saved_pos = e->pos;
>>  
>>  	/* exec table is optional */
>>  	if (unpack_nameX(e, AA_STRUCT, "xtable")) {
>> @@ -511,7 +511,7 @@ static bool unpack_trans_table(struct aa_ext *e, struct aa_profile *profile)
>>  
>>  fail:
>>  	aa_free_domain_entries(&profile->file.trans);
>> -	e->pos = pos;
>> +	e->pos = saved_pos;
>>  	return 0;
>>  }
>>  
>> -- 
>> 2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
