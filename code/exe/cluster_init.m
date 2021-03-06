function centers = cluster_init(x,k,method_centers,L,varargin)
%CLUSTER_INIT initializes cluster centroids

    switch method_centers
        case 'Random points'
            [C,~,~] = random_init(x,k);
            
        case 'First points'
            [~,C,~] = random_init(x,k);
            
        case 'K-Means++'
            C = kmpp_init(x,k);
            
        case 'Density K-Means++'
            if ~exist('L','var') || isempty(L)         
                C = dkmpp_init(x,k);
            else
                C = dkmpp_init(x,k,L);
            end
        case 'Kaufman'
            C = kaufman_init(x,k);
            
            
            
        case 'Maximin'    
            %Random reference point (original)
            C = maximin(x,k,1);   
            
        case 'Maximin-DETERMINISTIC'    
            %Random reference point (Katsavounidis)
            C = maximin(x,k,2);              
            
                
            
        case 'ROBIN-STOCHASTIC'
            %Random reference point (Brodinova)
            if ~exist('L','var') || isempty(L)     
                C = ROBIN(x,k,10);
            else
                C = ROBIN(x,k,10,'LOF',L,'DETERMINISTIC',0);
            end
            
        case 'ROBIN'
            %Origin reference point (original)
            if ~exist('L','var') || isempty(L)     
                C = ROBIN(x,k,10,'DETERMINISTIC',1);
            else
                C = ROBIN(x,k,10,'LOF',L,'DETERMINISTIC',1);
            end   
            
        case 'ROBIN-LOF'
            %Reference point with the minimum abs(1-LOF) (var1)
            if ~exist('L','var') || isempty(L)     
                C = ROBIN(x,k,10,'DETERMINISTIC',2);
            else
                C = ROBIN(x,k,10,'LOF',L,'DETERMINISTIC',2);
            end    
            
        otherwise
            error('Wrong clustering algorithm');
    end
    centers = x(C,:);
end
   