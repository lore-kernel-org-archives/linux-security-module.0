From: pablo@netfilter.org (Pablo Neira Ayuso)
Date: Thu, 20 Sep 2018 11:30:18 +0200
Subject: [PATCH] netfilter: nf_tables: add SECMARK support
In-Reply-To: <20180920085048.tps2v4jkko7zjav4@breakpoint.cc>
References: <20180919231402.4482-1-cgzones@googlemail.com>
	<75b3fed9-e549-4ed0-c435-ec4795fc1e39@schaufler-ca.com>
	<20180920085048.tps2v4jkko7zjav4@breakpoint.cc>
Message-ID: <20180920093018.qliwjvkeqjrouvsw@salvia>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, Sep 20, 2018 at 10:50:48AM +0200, Florian Westphal wrote:
> Casey Schaufler <casey@schaufler-ca.com> wrote:
> > On 9/19/2018 4:14 PM, Christian G?ttsche wrote:
> > > Add the ability to set the security context of packets within the nf_tables framework.
> > > Add a nft_object for holding security contexts in the kernel and manipulating packets on the wire.
> > > The contexts are kept as strings and are evaluated to security identifiers at runtime (packet arrival),
> > > so that the nft_objects do not need to be refreshed after security changes.
> > > The maximum security context length is set to 256.
> > >
> > > Based on v4.18.6
> > >
> > > Signed-off-by: Christian G?ttsche <cgzones@googlemail.com>
> > 
> > I've only had a cursory look at your patch, but how is it
> > different from what's in xt_SECMARK.c ?
> 
> this change is supposed to make secmark labeling accessible from
> nftables.
> 
> The advantage is that its now possible to use
> maps to assign secmarks from a single rule instead of using
> several rules:
> 
> nft add rule meta secmark set tcp dport map { 22 : tag-ssh, 80 :
> 	tag-http }
> 
> and so on.
> 
> > > +	for (i = 0; i < ARRAY_SIZE(nft_basic_objects); i++) {
> > > +		err = nft_register_obj(nft_basic_objects[i]);
> > > +		if (err)
> > > +			goto err;
> > > +	}
> > >  
> > > -	for (i = 0; i < ARRAY_SIZE(nft_basic_types); i++) {
> > > -		err = nft_register_expr(nft_basic_types[i]);
> > > +	for (j = 0; j < ARRAY_SIZE(nft_basic_types); j++) {
> > > +		err = nft_register_expr(nft_basic_types[j]);
> > >  		if (err)
> > >  			goto err;
> > >  	}
> > > @@ -248,8 +260,12 @@ int __init nf_tables_core_module_init(void)
> > >  	return 0;
> > >  
> > >  err:
> > > +	while (j-- > 0)
> > > +		nft_unregister_expr(nft_basic_types[j]);
> > > +
> > >  	while (i-- > 0)
> > > -		nft_unregister_expr(nft_basic_types[i]);
> > > +		nft_unregister_obj(nft_basic_objects[i]);
> > > +
> > >  	return err;
> 
> Do I read this right in that this is a error unroll bug fix?
> If so, could you please submit this as indepentent patch?
> 
> Fixes should go into nf.git whereas feature goes to nf-next.git.

nft_register_expr() never actually fails, so probably we can just turn
this into void.

@Christian: Please make sure you rebase your secmark patch on top of
nf-next.git.
