From: casey@schaufler-ca.com (Casey Schaufler)
Date: Wed, 29 Nov 2017 07:47:02 -0800
Subject: [PATCH 5/9] LSM: Manage remaining security blobs
In-Reply-To: <201711292021.CIC57334.OSQMFHOtOJFVLF@I-love.SAKURA.ne.jp>
References: <1473402e-a714-7ace-2698-b65d73e3f17e@schaufler-ca.com>
	<d3bd7b64-020b-ac7c-8fef-eed6a1ad5185@schaufler-ca.com>
	<201711292021.CIC57334.OSQMFHOtOJFVLF@I-love.SAKURA.ne.jp>
Message-ID: <b7a76b4d-b492-83c4-72ce-ca1e81c10ef3@schaufler-ca.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 11/29/2017 3:21 AM, Tetsuo Handa wrote:
> Hello.
>
> I browsed https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1734686
> and found a problem with how security blob is initialized.
>
> Casey Schaufler wrote:
>> +/**
>> + * lsm_sock_alloc - allocate a composite sock blob
>> + * @sock: the sock that needs a blob
>> + * @priority: allocation mode
>> + *
>> + * Allocate the sock blob for all the modules
>> + *
>> + * Returns 0, or -ENOMEM if memory can't be allocated.
>> + */
>> +int lsm_sock_alloc(struct sock *sock, gfp_t priority)
>> +{
>> +#ifdef CONFIG_SECURITY_LSM_DEBUG
>> +	if (sock->sk_security)
>> +		pr_info("%s: Inbound sock blob is not NULL.\n", __func__);
>> +#endif
> If none of LSM modules use sock->sk_security, sock->sk_security is not
> initialized to NULL (and sk_prot_alloc() does not always use __GFP_ZERO).

Thank you. I will be working on the next revision real soon and
will include a fix for this.


>
>> +	if (blob_sizes.lbs_sock == 0)
>> +		return 0;
>> +
>> +	sock->sk_security = kzalloc(blob_sizes.lbs_sock, priority);
>> +	if (sock->sk_security == NULL)
>> +		return -ENOMEM;
>> +	return 0;
>> +}
>> @@ -1609,12 +1851,18 @@ EXPORT_SYMBOL(security_socket_getpeersec_dgram);
>>  
>>  int security_sk_alloc(struct sock *sk, int family, gfp_t priority)
>>  {
>> +	int rc = lsm_sock_alloc(sk, priority);
>> +
>> +	if (rc)
>> +		return rc;
> In that report, no major LSMs are active because apparmor=0 is passed at
> kernel command line. Thus, security_sk_alloc() does not initialize
> sk->sk_security field and
>
>>  	return call_int_hook(sk_alloc_security, 0, sk, family, priority);
>>  }
>>  
>>  void security_sk_free(struct sock *sk)
>>  {
>>  	call_void_hook(sk_free_security, sk);
> causes random oops at kfree().
>
>> +	kfree(sk->sk_security);
>> +	sk->sk_security = NULL;
>>  }
> --
> To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
