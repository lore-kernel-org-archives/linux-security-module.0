From: marcelo.leitner@gmail.com (Marcelo Ricardo Leitner)
Date: Tue, 12 Dec 2017 15:08:04 -0200
Subject: [PATCH 2/4] sctp: Add ip option support
In-Reply-To: <20171212160800.GE3532@localhost.localdomain>
References: <20171127193121.2666-1-richard_c_haines@btinternet.com>
	<20171212160800.GE3532@localhost.localdomain>
Message-ID: <20171212170804.GF3532@localhost.localdomain>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Dec 12, 2017 at 02:08:00PM -0200, Marcelo Ricardo Leitner wrote:
> Hi Richard,
> 
> On Mon, Nov 27, 2017 at 07:31:21PM +0000, Richard Haines wrote:
> ...
> > --- a/net/sctp/socket.c
> > +++ b/net/sctp/socket.c
> > @@ -3123,8 +3123,10 @@ static int sctp_setsockopt_maxseg(struct sock *sk, char __user *optval, unsigned
> >  
> >  	if (asoc) {
> >  		if (val == 0) {
> > +			struct sctp_af *af = sp->pf->af;
> >  			val = asoc->pathmtu;
> > -			val -= sp->pf->af->net_header_len;
> > +			val -= af->ip_options_len(asoc->base.sk);
> > +			val -= af->net_header_len;
> >  			val -= sizeof(struct sctphdr) +
> >  					sizeof(struct sctp_data_chunk);
> >  		}
> 
> Right below here there is a call to sctp_frag_point(). That function
> also needs this tweak.
> 
> Yes, we should simplify all these calculations. I have a patch to use
> sctp_frag_point on where it is currently recalculating it on
> sctp_datamsg_from_user(), but probably should include other places as
> well.

I have no further comments on this patchset other than the above and
LGTM.
Thanks Richard.

  Marcelo
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
