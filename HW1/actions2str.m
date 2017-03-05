function [ lbls_M ] = actions2str(lbls_M_raw)
    %lbls_M_raw - array of string cells, with numeric actions
    lbls_M = lbls_M_raw(1:numel(lbls_M_raw));
    map = {'up', 'down', 'left', 'right', 'pick', 'drop'};
    lbls_M(strcmp('0', lbls_M)) = {''};
    lbls_M(strcmp('1', lbls_M)) = {'up'};
    lbls_M(strcmp('2', lbls_M)) = {'down'};
    lbls_M(strcmp('3', lbls_M)) = {'left'};
    lbls_M(strcmp('4', lbls_M)) = {'right'};
    lbls_M(strcmp('5', lbls_M)) = {'pick'};
    lbls_M(strcmp('6', lbls_M)) = {'drop'};
    for a1=1:6
      for a2=1:6
        action_combo = a2 + a1 * 6;
        lbls_M(strcmp(num2str(action_combo), lbls_M)) = {[map{a1}, '/', map{a2}]};
      end
    end
end

