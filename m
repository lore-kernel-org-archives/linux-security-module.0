From: john.johansen@canonical.com (John Johansen)
Date: Fri, 7 Sep 2018 09:37:34 -0700
Subject: [PATCH] apparmor: Fix network performance issue in
	aa_label_sk_perm
In-Reply-To: <20180907043357.4638-1-tonyj@suse.de>
References: <20180907043357.4638-1-tonyj@suse.de>
Message-ID: <c7676cd4-6ffe-0c6d-8d77-3fd20d692254@canonical.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 09/06/2018 09:33 PM, Tony Jones wrote:
> The netperf benchmark shows a 5.73% reduction in throughput for 
> small (64 byte) transfers by unconfined tasks.
> 
> DEFINE_AUDIT_SK() in aa_label_sk_perm() should not be performed 
> unconditionally, rather only when the label is confined.
> 
> netperf-tcp
>                             56974a6fc^              56974a6fc
> Min       64         563.48 (   0.00%)      531.17 (  -5.73%)
> Min       128       1056.92 (   0.00%)      999.44 (  -5.44%)
> Min       256       1945.95 (   0.00%)     1867.97 (  -4.01%)
> Min       1024      6761.40 (   0.00%)     6364.23 (  -5.87%)
> Min       2048     11110.53 (   0.00%)    10606.20 (  -4.54%)
> Min       3312     13692.67 (   0.00%)    13158.41 (  -3.90%)
> Min       4096     14926.29 (   0.00%)    14457.46 (  -3.14%)
> Min       8192     18399.34 (   0.00%)    18091.65 (  -1.67%)
> Min       16384    21384.13 (   0.00%)    21158.05 (  -1.06%)
> Hmean     64         564.96 (   0.00%)      534.38 (  -5.41%)
> Hmean     128       1064.42 (   0.00%)     1010.12 (  -5.10%)
> Hmean     256       1965.85 (   0.00%)     1879.16 (  -4.41%)
> Hmean     1024      6839.77 (   0.00%)     6478.70 (  -5.28%)
> Hmean     2048     11154.80 (   0.00%)    10671.13 (  -4.34%)
> Hmean     3312     13838.12 (   0.00%)    13249.01 (  -4.26%)
> Hmean     4096     15009.99 (   0.00%)    14561.36 (  -2.99%)
> Hmean     8192     18975.57 (   0.00%)    18326.54 (  -3.42%)
> Hmean     16384    21440.44 (   0.00%)    21324.59 (  -0.54%)
> Stddev    64           1.24 (   0.00%)        2.85 (-130.64%)
> Stddev    128          4.51 (   0.00%)        6.53 ( -44.84%)
> Stddev    256         11.67 (   0.00%)        8.50 (  27.16%)
> Stddev    1024        48.33 (   0.00%)       75.07 ( -55.34%)
> Stddev    2048        54.82 (   0.00%)       65.16 ( -18.86%)
> Stddev    3312       153.57 (   0.00%)       56.29 (  63.35%)
> Stddev    4096       100.25 (   0.00%)       88.50 (  11.72%)
> Stddev    8192       358.13 (   0.00%)      169.99 (  52.54%)
> Stddev    16384       43.99 (   0.00%)      141.82 (-222.39%)
> 
> Signed-off-by: Tony Jones <tonyj@suse.de>
> Fixes: 56974a6fcfef ("apparmor: add base infastructure for socket
> mediation")

hey Tony,

thanks for the patch, I am curious did you're investigation look
into what parts of DEFINE_AUDIT_SK are causing the issue?

regardless, I have pulled it into apparmor next

> ---
>  security/apparmor/net.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/security/apparmor/net.c b/security/apparmor/net.c
> index bb24cfa0a164..d5d72dd1ca1f 100644
> --- a/security/apparmor/net.c
> +++ b/security/apparmor/net.c
> @@ -146,17 +146,20 @@ int aa_af_perm(struct aa_label *label, const char *op, u32 request, u16 family,
>  static int aa_label_sk_perm(struct aa_label *label, const char *op, u32 request,
>  			    struct sock *sk)
>  {
> -	struct aa_profile *profile;
> -	DEFINE_AUDIT_SK(sa, op, sk);
> +	int error = 0;
>  
>  	AA_BUG(!label);
>  	AA_BUG(!sk);
>  
> -	if (unconfined(label))
> -		return 0;
> +	if (!unconfined(label)) {
> +		struct aa_profile *profile;
> +		DEFINE_AUDIT_SK(sa, op, sk);
>  
> -	return fn_for_each_confined(label, profile,
> -			aa_profile_af_sk_perm(profile, &sa, request, sk));
> +		error = fn_for_each_confined(label, profile,
> +			    aa_profile_af_sk_perm(profile, &sa, request, sk));
> +	}
> +
> +	return error;
>  }
>  
>  int aa_sk_perm(const char *op, u32 request, struct sock *sk)
> 
